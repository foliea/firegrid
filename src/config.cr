require "toml"
require "./keybindings"

class Config
  private FILENAMES = [
    File.join(ENV["HOME"], ".config", "firegrid", "firegrid.toml"),
    File.join(ENV["HOME"], ".firegrid.toml"),
    File.join("/etc", "firegrid", "firegrid.toml"),
  ]

  # Try it here: http://rubular.com/r/cPuMa8WlKA
  private HEXADECIMAL_COLOR_REGEXP = /^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$/

  private MIN_GRID_SIZE_TRESHOLD = 4_u32

  # Load default configuration file content at compile time, as this file won't be available
  # at run time.
  macro generate_default(body = File.read(File.join(ENV["PWD"], "config", "firegrid.toml")))
    private def self.default
      new({{body}}, filename: "")
    end
  end

  generate_default

  def self.load : self
    FILENAMES.each do |filename|
      next unless File.exists?(filename)

      return new(File.read(filename), filename).tap { |config| config.validate! }
    end
    default
  end

  def initialize(body : String, @filename : String)
    @content = TOML.parse(body)
  end

  def validate!
    validate_color!(border_color, key: "border")

    validate_color!(font_color, key: "font")

    if max_grid_size < MIN_GRID_SIZE_TRESHOLD
      raise InvalidConfiguration.new("Please specify at least 4 square keys in #{@filename}")
    end
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
