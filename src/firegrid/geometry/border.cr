require "./position"

class Firegrid::Geometry::Border
  getter :origin, :end

  def initialize(@origin : Position, @end : Position); end

  def ==(border : self)
    @origin == border.origin && @end == border.end
  end
end
