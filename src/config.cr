require "toml"
require "./font"
require "./keybindings"

class Config
  private FILENAME = File.join(ENV["HOME"], ".config", "firegrid", "firegrid.toml")

  getter :font, :keybindings

  def initialize(filename = FILENAME)
    @content = TOML.parse(File.read(filename))

    @font = Font.new(font_file, size: font_size, color_code: font_color_code)

    @keybindings = Keybindings.new(keys)
  end

  private def font_file
    @content["font"].as(Hash)["file"].as(String)
  end

  private def font_size
    @content["font"].as(Hash)["size"].as(Int64).to_u32
  end

  private def font_color_code
    @content["font"].as(Hash)["color"].as(Array(TOML::Type)).map { |key| key.to_s.to_u32 }
  end

  private def keys
    {"squares" => square_keys}
  end

  private def square_keys
    @content["keys"].as(Hash)["squares"].as(Array(TOML::Type)).map { |key| key.to_s }
  end
end
