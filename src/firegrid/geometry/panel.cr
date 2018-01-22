require "./grid"

class Firegrid::Geometry::Panel
  private MINIMIZED_MAX_SIZE =   4
  private MINIMIZE_RATE      =   5
  private PRECISON_RATE      = 1.5

  def initialize(@width : Int32, @height : Int32, @max_grid_size : Int32)
    @grid = Grid.new(@width, @height, max_size: @max_grid_size)
  end

  def select(tile_id : Int32) : Tuple(Symbol, Position | Nil)
    return {:unclickable, nil} if tile_id >= @grid.tiles.size

    tile = @grid.tiles[tile_id]

    return {:clickable, tile.center} if below_dimensions?(tile, PRECISON_RATE)

    focus(tile)

    {:unclickable, nil}
  end

  def borders
    @grid.tiles.map { |tile| tile.borders.values }.flatten.select do |b|
      !((b.origin.x.zero? && b.limit.x.zero?) || (b.origin.y.zero? && b.limit.y.zero?))
    end
  end

  def labels(texts : Array(String))
    @grid.tiles.map_with_index do |tile, index|
      Geometry::Label.new(tile, texts[index][0..1])
    end
  end

  private def focus(tile)
    max_size = below_dimensions?(tile, MINIMIZE_RATE) ? MINIMIZED_MAX_SIZE : @max_grid_size

    @grid = tile.to_grid(max_size)
  end

  private def below_dimensions?(tile, rate)
    tile.width <= @width * rate / 100 || tile.height <= @height * rate / 100
  end
end
