require "./grid"
require "./border"
require "./position"
require "./label"

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

  def label
    label_size = (@width < @height ? @width : @height) / 2

    label_origin = Position.new(center.x - label_size / 2, center.y - label_size / 2)

    Label.new(label_origin, label_size)
  end

  def borders
    x = @origin.x.zero? ? 1_u32 : @origin.x
    y = @origin.y.zero? ? 1_u32 : @origin.y
    {
      "top" => Border.new(
        Position.new(x, y), Position.new(x + @width, y)
      ),
      "left" => Border.new(
        Position.new(x, y), Position.new(x, y + @height)
      ),
      "right" => Border.new(
        Position.new(x + @width, y), Position.new(x + @width, y + @height)
      ),
      "bottom" => Border.new(
        Position.new(x, y + @height), Position.new(x + @width, y + @height)
      ),
    }
  end

  def to_grid
    Grid.new(@width, @height, origin: @origin)
  end

  def ==(square : self)
    @width == square.width && @height == square.height && @origin == square.origin
  end
end
