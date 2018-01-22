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

    tile_width = (@width / horizontal_count).to_i

    tile_height = (@height / vertical_count).to_i

    (0..vertical_count - 1).map do |line|
      (0..horizontal_count - 1).map do |row|
        tile_x = (@origin.x + tile_width * row).to_i
        tile_y = (@origin.y + tile_height * line).to_i

        build_tile(tile_width, tile_height, tile_x, tile_y)
      end
    end.flatten
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
    (vertical_count * @width.to_f / @height.to_f).floor
  end

  private def build_tile(width, height, x, y)
    Tile.new(width, height, origin: Position.new(x, y))
  end
end
