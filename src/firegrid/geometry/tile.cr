require "./border"

class Firegrid::Geometry::Tile
  getter width : Int32, height : Int32, origin : Position

  def initialize(@width : Int32, @height : Int32, @origin : Position); end

  def center : Position
    Position.new(@origin.x + @width / 2, @origin.y + @height / 2)
  end

  def borders : Hash(String, Border)
    {
      "top"    => Border.new(top_left_corner, top_right_corner),
      "left"   => Border.new(top_left_corner, bottom_left_corner),
      "right"  => Border.new(top_right_corner, bottom_right_corner),
      "bottom" => Border.new(bottom_left_corner, bottom_right_corner),
    }
  end

  def to_grid(max_size : Int32) : Grid
    Grid.new(@width, @height, origin: @origin, max_size: max_size)
  end

  def ==(tile : self) : Bool
    @width == tile.width && @height == tile.height && @origin == tile.origin
  end

  private def top_left_corner
    Position.new(@origin.x, @origin.y)
  end

  private def top_right_corner
    Position.new(@origin.x + @width, @origin.y)
  end

  private def bottom_left_corner
    Position.new(@origin.x, @origin.y + @height)
  end

  private def bottom_right_corner
    Position.new(@origin.x + @width, @origin.y + @height)
  end
end
