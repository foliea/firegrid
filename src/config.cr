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

  private MIN_GRID_SIZE = 4_u32

  def self.default : self
    FILENAMES.each do |filename|
      next unless File.exists?(filename)

      return new(File.read(filename), filename).tap { |config| config.validate! }
    end

    raise InvalidConfiguration.new("Configuration file not found! (#{FILENAMES})")
  end

  def initialize(body : String, @filename : String)
    @content = TOML.parse(body)
  end

  def validate!
    validate_color!(border_color, key: "border")

    validate_color!(font_color, key: "font")

    if grid_size < MIN_GRID_SIZE
      raise InvalidConfiguration.new("Please specify at least 4 square keys in #{@filename}")
    end
  end

  def border_color
    @content["colors"].as(Hash)["border"].as(String)
  end

  def font_color
    @content["colors"].as(Hash)["font"].as(String)
  end

  def grid_size
    keys["squares"].size.to_u32
  end

  def keybindings
    @_keybindings ||= Keybindings.new(keys)
  end

  private def validate_color!(value, key)
    msg = "#{key.capitalize} color must be a valid hexadecimal color in #{@filename}"

    raise InvalidConfiguration.new(msg) unless HEXADECIMAL_COLOR_REGEXP.match(value)
  end

  private def keys
    {"squares" => square_keys}
  end

  private def square_keys
    @content["keys"].as(Hash)["squares"].as(Array(TOML::Type)).map { |key| key.to_s }
  end
end
