require "./position"
require "./square"

class Firegrid::Geometry::Label
  getter content : String

  def initialize(@square : Square, @content : String); end

  def size
    (@square.width < @square.height ? @square.width : @square.height) / 2
  end

  def origin
    Position.new(@square.center.x - size / 2, @square.center.y + size / 2)
  end
end
