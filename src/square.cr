require "./grid"

class Square
  private PRECISON_RATE = 2_u32

  getter :width, :height, :origin

  def initialize(@width : UInt32, @height : UInt32, @origin : Position); end

  def precise_for?(width : UInt32, height : UInt32)
    @width <= width * PRECISON_RATE / 100 || @height <= height * PRECISON_RATE / 100
  end

  def center
    Position.new(@origin.x + @width / 2, @origin.y + @height / 2)
  end

  def to_grid
    Grid.new(@width, @height, origin: @origin)
  end

  def ==(square : self)
    @width == square.width && @height == square.height && @origin == square.origin
  end
end
