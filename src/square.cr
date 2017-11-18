require "./grid"

class Square

  getter :origin

  def initialize(@width : UInt32, @height : UInt32, @origin = Position.default); end

  def to_grid
    Grid.new(@width, @height, origin: @origin)
  end

end
