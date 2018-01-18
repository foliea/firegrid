class Firegrid::Geometry::Position
  getter x : Int32, y : Int32

  def self.default : self
    new(0, 0)
  end

  def initialize(@x : Int32, @y : Int32); end

  def inner?(point_a : self, point_b : self) : Bool
    x >= point_a.x && x <= point_b.x && y >= point_a.y && y <= point_b.y
  end

  def ==(position : self) : Bool
    @x == position.x && @y == position.y
  end
end
