require "./square"

class Firegrid::Geometry::Grid
  private MIN_VERTICAL_SQUARE_COUNT = 1_u32

  getter width : UInt32, height : UInt32, origin : Position, max_size : UInt32

  def initialize(
    @width : UInt32,
    @height : UInt32,
    @max_size : UInt32,
    @origin = Position.default
  ); end

  def squares : Array(Square)
    horizontal_count, vertical_count = format

    size = horizontal_count * vertical_count

    square_width = @width / horizontal_count

    square_height = @height / vertical_count

    (0..size - 1).map do |index|
      square_origin = Position.new(
        @origin.x + (index - horizontal_count * (index / horizontal_count)) * square_width,
        @origin.y + index / horizontal_count * square_height
      )
      Square.new(square_width, square_height, origin: square_origin)
    end
  end

  def ==(grid : self) : Bool
    @width == grid.width &&
      @height == grid.height &&
      @origin == grid.origin &&
      @max_size == grid.max_size
  end

  private def format(vertical_count = MIN_VERTICAL_SQUARE_COUNT)
    horizontal_count = horizontal_squares_count(vertical_count)

    total_count = horizontal_count * vertical_count

    if total_count > @max_size
      return [horizontal_squares_count(vertical_count - 1), vertical_count - 1]
    end

    format(vertical_count + 1)
  end

  private def horizontal_squares_count(vertical_count : UInt32)
    (vertical_count * @width.to_f / @height.to_f).floor.to_u32
  end
end
