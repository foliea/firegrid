require "crsfml"

class Font
  def initialize(@filename : String, @color_code : Array(UInt32)); end

  def color
    red, green, blue = @color_code

    SF::Color.new(red, green, blue)
  end

  def to_sf_font
    @_sf_font ||= SF::Font.from_file(@filename)
  end
end
