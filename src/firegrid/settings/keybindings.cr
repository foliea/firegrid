class Firegrid::Settings::Keybindings
  private HUMAN_READABLE_KEYS = {
    "Escape"    => "\e",
    "Backspace" => "\b",
    "Enter"     => "\r",
    "Tab"       => "\t",
    "Del"       => "\u007f",
  }

  def initialize(@keys : Hash(String, Array(String) | String)); end

  def exit_keycode?(keycode : String) : Bool
    @keys["exit"].as(String) == human_readable_key(keycode)
  end

  def square_keycode?(keycode : String) : Bool
    @keys["squares"].includes?(human_readable_key(keycode))
  end

  def square_id(keycode : String) : Int32
    raise NoMatchingKey.new unless square_keycode?(keycode)

    @keys["squares"].index(human_readable_key(keycode)).not_nil!
  end

  def square_key(id : Int32) : String
    raise NoMatchingKey.new unless (0..@keys["squares"].size).includes?(id)

    @keys["squares"][id].as(String)
  end

  private def human_readable_key(keycode : String) : String
    HUMAN_READABLE_KEYS.has_value?(keycode) ? HUMAN_READABLE_KEYS.key(keycode) : keycode
  end
end
