require "toml"
require "./keybindings"

class Config
  private ALL_FILENAMES = [
    File.join(ENV["HOME"], ".config", "firegrid", "firegrid.toml"),
    File.join(ENV["HOME"], ".firegrid.toml"),
    File.join("/etc", "firegrid", "firegrid.toml"),
  ]

  def self.default : self
    ALL_FILENAMES.each do |filename|
      return new(File.read(filename), filename) if File.exists?(filename)
    end
    raise InvalidConfiguration.new("Configuration file not found! (#{ALL_FILENAMES})")
  end

  def initialize(body : String, @filename : String)
    @content = TOML.parse(body)
  end

  def border_color
    @content["colors"].as(Hash)["border"].as(String)
  end

  def font_color
    @content["colors"].as(Hash)["font"].as(String)
  end

  def keybindings
    @_keybindings ||= Keybindings.new(keys)
  end

  private def keys
    {"squares" => square_keys}
  end

  private def square_keys
    @content["keys"].as(Hash)["squares"].as(Array(TOML::Type)).map { |key| key.to_s }
  end
end
