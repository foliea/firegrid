require "./position"

class Firegrid::Geometry::Border
  getter origin : Position, limit : Position

  def initialize(@origin : Position, @limit : Position); end

  def ==(border : self) : Bool
    @origin == border.origin && @limit == border.limit
  end
end
