require "./errors"

class Keybindings
  private ESCAPE_KEY = "\e"

  def initialize(@keys : Hash(String, Array(String))); end

  def close_key?(key)
    key == ESCAPE_KEY
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

    @keys["squares"][id]
  end
end
