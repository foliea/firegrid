require "./position"

class Grid

  getter :width, :height, :origin

  def initialize(@width : UInt32, @height : UInt32, @origin = Position.default); end

  def center
    Position.new((@origin.x + @width) / 2, (@origin.y + @height) / 2)
  end

  def ==(grid : self)
    @width == grid.width && @height == grid.height && @origin == grid.origin
  end

end
