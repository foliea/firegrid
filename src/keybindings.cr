require "./errors"

class Keybindings
  private HUMAN_READABLE_KEYS = {
    "Escape" => "\e",
    "Tab" => "\t"
  }

  def initialize(@keys : Hash(String, Array(String) | String)); end

  def exit_key?(key)
    convert_key(@keys["exit"]) == key
  end

  def square_key?(key)
    @keys["squares"].includes?(key)
  end

  def square_id(key)
    raise NoMatchingKey.new unless square_key?(key)

    @keys["squares"].index(key).not_nil!
  end

  def square_key(id)
    raise NoMatchingKey.new unless (0..@keys["squares"].size).includes?(id)

    convert_key(@keys["squares"][id].as(String))
  end

  private def convert_key(key)
    HUMAN_READABLE_KEYS.has_key?(key) ? HUMAN_READABLE_KEYS[key] : key
  end
end
