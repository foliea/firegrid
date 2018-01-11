require "./border"

class Firegrid::Geometry::Square
  getter width : UInt32, height : UInt32, origin : Position

  def initialize(@width : UInt32, @height : UInt32, @origin : Position); end

  def center : Position
    Position.new(@origin.x + @width / 2, @origin.y + @height / 2)
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

  def to_grid(max_size : UInt32) : Grid
    Grid.new(@width, @height, origin: @origin, max_size: max_size)
  end

  def ==(square : self) : Bool
    @width == square.width && @height == square.height && @origin == square.origin
  end
end
