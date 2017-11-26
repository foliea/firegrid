require "crsfml"

class Font
  getter :size

  def initialize(filename, @size : UInt32, @color_code : Array(UInt32))
    @font = SF::Font.from_file(filename)
  end

  def color
    red, green, blue, alpha = @color_code

    SF::Color.new(red, green, blue, alpha)
  end

  def to_sf_font
    @font
  end
end
