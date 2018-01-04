require "./border"
require "./grid"
require "./label"

class Firegrid::Geometry::Square
  private PRECISON_RATE = 1.5

  getter width : UInt32, height : UInt32, origin : Position

  def initialize(@width : UInt32, @height : UInt32, @origin : Position); end

  def precise_for?(width : UInt32, height : UInt32) : Bool
    @width <= width * PRECISON_RATE / 100 || @height <= height * PRECISON_RATE / 100
  end

  def center : Position
    Position.new(@origin.x + @width / 2, @origin.y + @height / 2)
  end

  def label : Label
    label_size = (@width < @height ? @width : @height) / 2

    label_origin = Position.new(center.x - label_size / 2, center.y + label_size / 2)

    Label.new(label_origin, label_size)
  end

  def borders : Hash(String, Border)
    x = @origin.x
    y = @origin.y
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

  def to_grid : Grid
    Grid.new(@width, @height, origin: @origin)
  end

  def ==(square : self) : Bool
    @width == square.width && @height == square.height && @origin == square.origin
  end
end
