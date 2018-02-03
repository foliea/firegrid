class Firegrid::Geometry::Grid
  private MIN_VERTICAL_SQUARE_COUNT = 1

  getter width : Int32, height : Int32, origin : Position, max_size : Int32

  def initialize(
    @width : Int32,
    @height : Int32,
    @max_size : Int32,
    @origin = Position.default
  ); end

  def tiles : Array(Tile)
    horizontal_count, vertical_count = format

    (0..(horizontal_count * vertical_count) - 1).map do |index|
      row = index / horizontal_count

      build_tile_at(row: row, column: index - row * horizontal_count)
    end
  end

  def ==(grid : self) : Bool
    @width == grid.width && @height == grid.height && @origin == grid.origin &&
      @max_size == grid.max_size
  end

  private def format(vertical_count = MIN_VERTICAL_SQUARE_COUNT)
    horizontal_count = horizontal_tiles_count(vertical_count)

    total_count = horizontal_count * vertical_count

    if total_count > @max_size
      return [horizontal_tiles_count(vertical_count - 1), vertical_count - 1]
    end

    format(vertical_count + 1)
  end

  private def horizontal_tiles_count(vertical_count)
    (vertical_count * @width.to_f / @height.to_f).floor.to_i
  end

  private def build_tile_at(row, column)
    x = (@origin.x + tile_width * column).to_i
    y = (@origin.y + tile_height * row).to_i

    Tile.new(tile_width, tile_height, origin: Position.new(x, y))
  end

  private def tile_width
    horizontal_count, _ = format

    tile_width = (@width / horizontal_count).to_i
  end

  private def tile_height
    _, vertical_count = format

    (@height / vertical_count).to_i
  end
end
