require "./position"
require "./square"

class Grid
  private MIN_VERTICAL_SQUARE_COUNT      =  1_u32
  private MAX_TOTAL_SQUARE_COUNT         = 40_u32
  private RESIZED_MAX_TOTAL_SQUARE_COUNT =  4_u32
  private RESIZE_REQUIRED_RATE           =  5_u32

  getter :width, :height, :origin, :max_size

  def initialize(
                 @width : UInt32,
                 @height : UInt32,
                 @origin = Position.default,
                 @max_size = MAX_TOTAL_SQUARE_COUNT); end

  def resize_for(width : UInt32, height : UInt32)
    return self unless resize_for?(width, height)

    self.class.new(@width, @height, @origin, RESIZED_MAX_TOTAL_SQUARE_COUNT)
  end

  def selectable?(square_id)
    square_id < squares.size
  end

  def squares
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

  def ==(grid : self)
    @width == grid.width && @height == grid.height && @origin == grid.origin
  end

  private def resize_for?(width : UInt32, height : UInt32)
    @width <= width * RESIZE_REQUIRED_RATE / 100 ||
      @height <= height * RESIZE_REQUIRED_RATE / 100
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
