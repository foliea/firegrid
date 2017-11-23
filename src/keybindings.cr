require "./errors"

class Keybindings
  private KEYCODE_KEYS = {
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

  def initialize(@keys : Hash(String, Array(String))); end

  def square_key?(keycode)
    @keys["squares"].includes?(key_from(keycode))
  end

  def square_id(keycode)
    raise NoMatchingKey.new unless square_key?(keycode)

    @keys["squares"].index(key_from(keycode))
  end

  def square_key(id)
    @keys["squares"][id]
  end

  private def key_from(keycode)
    KEYCODE_KEYS.has_key?(keycode) ? KEYCODE_KEYS[keycode] : keycode
  end
end
