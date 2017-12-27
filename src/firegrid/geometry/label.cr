require "./position"

class Firegrid::Geometry::Label
  getter :origin, :size

  def initialize(@origin : Position, @size : UInt32); end

  def ==(label)
    @origin == label.origin && @size == label.size
  end
end
