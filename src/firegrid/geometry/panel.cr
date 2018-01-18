class Firegrid::Geometry::Panel
  private MINIMIZED_MAX_SIZE =   4
  private MINIMIZE_RATE      =   5
  private PRECISON_RATE      = 1.5

  getter grid : Grid

  def initialize(@width : Int32, @height : Int32, @max_grid_size : Int32)
    @grid = Grid.new(@width, @height, max_size: @max_grid_size)
  end

  def select(square_id : Int32) : Tuple(Symbol, Position | Nil)
    return {:unclickable, nil} if square_id >= @grid.squares.size

    square = @grid.squares[square_id]

    return {:clickable, square.center} if below_dimensions?(square, PRECISON_RATE)

    focus(square)

    {:unclickable, nil}
  end

  private def focus(square : Square)
    max_size = below_dimensions?(square, MINIMIZE_RATE) ? MINIMIZED_MAX_SIZE : @max_grid_size

    @grid = square.to_grid(max_size)
  end

  private def below_dimensions?(square : Square, rate : Int32 | Float64)
    square.width <= @width * rate / 100 || square.height <= @height * rate / 100
  end
end
