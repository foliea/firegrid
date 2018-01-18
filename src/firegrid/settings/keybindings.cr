class Firegrid::Settings::Keybindings
  private HUMAN_READABLE_KEYS = {
    "Escape"    => "\e",
    "Backspace" => "\b",
    "Enter"     => "\r",
    "Tab"       => "\t",
    "Del"       => "\u007f",
  }

  def initialize(@keys : Hash(Symbol, Array(String) | String)); end

  def exit_keycode?(keycode : String) : Bool
    @keys[:exit].as(String) == human_readable_key(keycode)
  end

  def square_keycode?(keycode : String) : Bool
    squares.includes?(human_readable_key(keycode))
  end

  def square_id(keycode : String) : Int32
    raise NoMatchingKey.new unless square_keycode?(keycode)

    squares.index(human_readable_key(keycode)).not_nil!
  end

  def square_key(id : Int32) : String
    raise NoMatchingKey.new unless (0..squares.size).includes?(id)

    squares[id].as(String)
  end

  private def human_readable_key(keycode)
    HUMAN_READABLE_KEYS.has_value?(keycode) ? HUMAN_READABLE_KEYS.key(keycode) : keycode
  end

  private def squares
    @keys[:squares]
  end
end
