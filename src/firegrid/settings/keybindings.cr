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

  def tile_keycode?(keycode : String) : Bool
    tiles.includes?(human_readable_key(keycode))
  end

  def tile_id(keycode : String) : Int32
    raise NoMatchingKey.new unless tile_keycode?(keycode)

    tiles.index(human_readable_key(keycode)).not_nil!
  end

  def tile_key(id : Int32) : String
    raise NoMatchingKey.new unless (0..tiles.size).includes?(id)

    tiles[id].as(String)
  end

  private def human_readable_key(keycode)
    HUMAN_READABLE_KEYS.has_value?(keycode) ? HUMAN_READABLE_KEYS.key(keycode) : keycode
  end

  private def tiles
    @keys[:tiles]
  end
end
