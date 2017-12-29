require "toml"
require "./keybindings"
require "./errors"

class Firegrid::Settings::Config
  private FILENAMES = [
    File.join(ENV["HOME"], ".config", "firegrid", "firegrid.toml"),
    File.join(ENV["HOME"], ".firegrid.toml"),
    File.join("/etc", "firegrid", "firegrid.toml"),
  ]

  # Load default configuration file content at compile time, as this file won't be available
  # at run time.
  private DEFAULT_BODY = {{ system("cat", "config/firegrid.toml").stringify }}

  # Try it here: http://rubular.com/r/cPuMa8WlKA
  private HEXADECIMAL_COLOR_REGEXP = /^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$/

  private MIN_GRID_SIZE_TRESHOLD = 4_u32

  def self.load : self
    FILENAMES.each do |filename|
      next unless File.exists?(filename)

      return new(File.read(filename), filename).tap { |config| config.validate! }
    end
    new(DEFAULT_BODY, filename: "")
  end

  def initialize(body : String, @filename : String)
    @content = TOML.parse(body)
  end

  def validate!
    validate_color!(border_color, key: "border")

    validate_color!(font_color, key: "font")

    validate_keys!
  end

  def border_color
    @content["colors"].as(Hash)["border"].as(String)
  end

  def font_color
    @content["colors"].as(Hash)["font"].as(String)
  end

  def max_grid_size
    square_keys.size.to_u32
  end

  def keybindings
    @_keybindings ||= Keybindings.new({"exit" => exit_key, "squares" => square_keys})
  end

  private def validate_color!(value, key)
    msg = "#{key.capitalize} color must be a valid hexadecimal color in #{@filename}"

    raise InvalidConfiguration.new(msg) unless HEXADECIMAL_COLOR_REGEXP.match(value)
  end

  private def validate_keys!
    if max_grid_size < MIN_GRID_SIZE_TRESHOLD
      raise InvalidConfiguration.new("Please specify at least 4 square keys in #{@filename}")
    end

    all_keys = square_keys.concat([exit_key])

    if all_keys != all_keys.uniq
      raise InvalidConfiguration.new("Please remove duplicate keys in #{@filename}")
    end
  end

  private def exit_key
    keys["exit"].as(String)
  end

  private def square_keys
    keys["squares"].as(Array(TOML::Type)).map { |key| key.to_s }
  end

  private def keys
    @content["keys"].as(Hash)
  end
end
