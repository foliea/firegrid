require "./position"

class Firegrid::Geometry::Label
  getter origin : Position, size : UInt32

  def initialize(@origin : Position, @size : UInt32); end

  def ==(label : self) : Bool
    @origin == label.origin && @size == label.size
  end
end
