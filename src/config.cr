require "toml"
require "./errors"

# TODO: validate configuration, file presence etc
# Handle when there is less than 40 keys.
# Config could also be splitted into multiple files
class Config
  KEYCODE_KEYS = {
    "lbracket"  => "[",
    "rbracket"  => "]",
    "backslash" => "\\",
    "semicolon" => ";",
    "quote"     => "'",
    "comma"     => ",",
    "period"    => ".",
    "slash"     => "/",
    "tilde"     => "`",
    "dash"      => "-",
    "equal"     => "=",
    "num0"      => "0",
    "num1"      => "1",
    "num2"      => "2",
    "num3"      => "3",
    "num4"      => "4",
    "num5"      => "5",
    "num6"      => "6",
    "num7"      => "7",
    "num8"      => "8",
    "num9"      => "9",
  }

  FILENAME = File.join(ENV["HOME"], ".config", "firegrid", "firegrid.toml")

  def initialize(filename = FILENAME)
    @content = TOML.parse(File.read(filename))
  end

  # TODO: test this
  def font_file
    @content["font"].as(Hash)["file"].as(String)
  end

  def square_key?(keycode)
    square_keys.includes?(key_from(keycode))
  end

  def square_id(keycode)
    raise NoMatchingKey.new unless square_key?(keycode)

    square_keys.index(key_from(keycode))
  end

  # TODO: test this
  def square_key(id)
    square_keys[id]
  end

  private def key_from(keycode)
    KEYCODE_KEYS.has_key?(keycode) ? KEYCODE_KEYS[keycode] : keycode
  end

  private def square_keys
    keys["squares"].as(Array(TOML::Type)).map { |key| key.to_s }
  end

  private def keys
    @content["keys"].as(Hash)
  end
end
