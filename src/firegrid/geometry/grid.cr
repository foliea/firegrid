class Firegrid::Geometry::Grid
  private MIN_VERTICAL_SQUARE_COUNT = 1

  getter width : Int32, height : Int32, origin : Position, max_size : Int32

  def initialize(
    @width : Int32,
    @height : Int32,
    @max_size : Int32,
    @origin = Position.default
  ); end

  def squares : Array(Square)
    horizontal_count, vertical_count = format

    square_width = (@width / horizontal_count).to_i

    square_height = (@height / vertical_count).to_i

    (0..vertical_count - 1).map do |line|
      (0..horizontal_count - 1).map do |row|
        x = (@origin.x + square_width * row).to_i
        y = (@origin.y + square_height * line).to_i

        Square.new(square_width, square_height, origin: Position.new(x, y))
      end
    end.flatten
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

  private def horizontal_squares_count(vertical_count : Int32)
    (vertical_count * @width.to_f / @height.to_f).floor
  end
end
