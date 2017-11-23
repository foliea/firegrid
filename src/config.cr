require "toml"
require "./font"
require "./keybindings"

class Config
  private FILENAME = File.join(ENV["HOME"], ".config", "firegrid", "firegrid.toml")

  getter :font, :keybindings

  def initialize(filename = FILENAME)
    @content = TOML.parse(File.read(filename))

    @font = Font.new(font_file)

    @keybindings = Keybindings.new(keys)
  end

  private def font_file
    @content["font"].as(Hash)["file"].as(String)
  end

  private def keys
    {"squares" => square_keys}
  end

  private def square_keys
    @content["keys"].as(Hash)["squares"].as(Array(TOML::Type)).map { |key| key.to_s }
  end
end
