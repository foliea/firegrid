class Firegrid::Settings::Keybindings
  private HUMAN_READABLE_KEYS = {
    "Escape"    => "\e",
    "Backspace" => "\b",
    "Enter"     => "\r",
    "Tab"       => "\t",
    "Del"       => "\u007f",
  }

  def initialize(@keys : Hash(String, Array(String) | String)); end

  def exit_key?(key : String) : Bool
    convert_key(@keys["exit"].as(String)) == key
  end

  def square_key?(key : String) : Bool
    @keys["squares"].includes?(key)
  end

  def square_id(key : String) : Int32
    raise NoMatchingKey.new unless square_key?(key)

    @keys["squares"].index(key).not_nil!
  end

  def square_key(id : Int32) : String
    raise NoMatchingKey.new unless (0..@keys["squares"].size).includes?(id)

    convert_key(@keys["squares"][id].as(String))
  end

  private def convert_key(key : String) : String
    HUMAN_READABLE_KEYS.has_key?(key) ? HUMAN_READABLE_KEYS[key] : key
  end
end
