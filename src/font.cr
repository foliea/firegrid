require "crsfml"

class Font
  getter :size

  def initialize(@filename : String, @size : UInt32, @color_code : Array(UInt32)); end

  def color
    red, green, blue, alpha = @color_code

    SF::Color.new(red, green, blue, alpha)
  end

  def to_sf_font
    @_sf_font ||= SF::Font.from_file(@filename)
  end
end
