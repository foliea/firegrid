class Position

  getter :x, :y

  def self.default : self
    new(0_u32, 0_u32)
  end

  def initialize(@x : UInt32, @y : UInt32); end

  def ==(position : self)
    @x == position.x && @y == position.y
  end

end
