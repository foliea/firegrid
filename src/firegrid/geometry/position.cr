class Firegrid::Geometry::Position
  getter :x, :y

  def self.default : self
    new(0_u32, 0_u32)
  end

  def initialize(@x : UInt32, @y : UInt32); end

  def between?(point_a : self, point_b : self)
    x >= point_a.x && x <= point_b.x && y >= point_a.y && y <= point_b.y
  end

  def ==(position : self)
    @x == position.x && @y == position.y
  end
end
