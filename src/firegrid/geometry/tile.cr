require "./border"

class Firegrid::Geometry::Tile
  getter width : Int32, height : Int32, origin : Position

  def initialize(@width : Int32, @height : Int32, @origin : Position); end

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

  def to_grid(max_size : Int32) : Grid
    Grid.new(@width, @height, origin: @origin, max_size: max_size)
  end

  def ==(tile : self) : Bool
    @width == tile.width && @height == tile.height && @origin == tile.origin
  end
end
