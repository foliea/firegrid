require "./grid"

class Square

  getter :width, :height, :origin

  def initialize(@width : UInt32, @height : UInt32, @origin = Position.default); end

  def to_grid
    Grid.new(@width, @height, origin: @origin)
  end

  def ==(square : self)
    @width == square.width && @height == square.height && @origin == square.origin
  end

end
