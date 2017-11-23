require "crsfml"

class Font
  getter :size

  def initialize(filename, @size : UInt32)
    @font = SF::Font.from_file(filename)
  end

  def object
    @font
  end
end
