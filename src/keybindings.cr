require "./errors"

class Keybindings
  private KEYCODE_KEYS = {
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
    "escape"    => "esc",
    "lbracket"  => "[",
    "rbracket"  => "]",
    "semicolon" => ";",
    "comma"     => ",",
    "period"    => ".",
    "quote"     => "'",
    "slash"     => "/",
    "backslash" => "\\",
    "tilde"     => "`",
    "equal"     => "=",
    "dash"      => "-",
    "f1"        => "F1",
    "f2"        => "F2",
    "f3"        => "F3",
    "f4"        => "F4",
    "f5"        => "F5",
    "f6"        => "F6",
    "f7"        => "F7",
    "f8"        => "F8",
    "f9"        => "F9",
    "f10"       => "F10",
    "f11"       => "F11",
    "f12"       => "F12",
  }

  def initialize(@keys : Hash(String, Array(String))); end

  def square_key?(keycode)
    @keys["squares"].includes?(key_from(keycode))
  end

  def square_id(keycode)
    raise NoMatchingKey.new unless square_key?(keycode)

    @keys["squares"].index(key_from(keycode)).not_nil!
  end

  def square_key(id)
    raise NoMatchingKey.new unless (0..@keys["squares"].size).includes?(id)

    @keys["squares"][id]
  end

  private def key_from(keycode)
    KEYCODE_KEYS.has_key?(keycode) ? KEYCODE_KEYS[keycode] : keycode
  end
end
