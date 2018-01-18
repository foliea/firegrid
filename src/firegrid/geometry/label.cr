require "./position"
require "./square"

class Firegrid::Geometry::Label
  getter content : String

  private SQUARE_HEIGHT_RATE = 0.5

  def initialize(@square : Square, @content : String); end

  def size : Int32
    (@square.height * SQUARE_HEIGHT_RATE).to_i
  end

  def origin : Position
    Position.new(@square.center.x - half_size * @content.size, @square.center.y + half_size)
  end

  private def half_size
    size / 2
  end
end
