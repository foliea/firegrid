require "./position"
require "./tile"

class Firegrid::Geometry::Label
  getter tile : Tile, content : String

  private SQUARE_HEIGHT_RATE = 0.5

  def initialize(@tile : Tile, @content : String); end

  def size : Int32
    (@tile.height * SQUARE_HEIGHT_RATE).to_i
  end

  def origin : Position
    Position.new(@tile.center.x - half_size * @content.size, @tile.center.y + half_size)
  end

  def ==(label : self)
    @tile == label.tile && @content == label.content
  end

  private def half_size
    size / 2
  end
end
