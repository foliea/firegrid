require "qt5"
require "./settings/config"
require "./geometry/grid"

class Firegrid::Overlay < Qt::Widget
  def initialize(@display : Display, @config : Settings::Config, *args)
    super(*args)

    @grid = Geometry::Grid.new(
      @display.width, @display.height, max_size: @config.max_grid_size
    )
  end

  def paint_event(_event)
    Qt::Painter.draw(self) do |painter|
      draw_lines(painter)
      draw_texts(painter)
    end
  end

  def select(square_id : Int32)
    return unless @grid.selectable?(square_id)

    square = @grid.squares[square_id]

    return square.center if square.precise_for?(@display.width, @display.height)

    @grid = square.to_grid(@config.max_grid_size).resize_for(@display.width, @display.height)

    repaint
  end

  private def draw_lines(painter : Qt::Painter)
    painter.pen = Qt::Color.new(@config.colors[:border])

    @grid.squares.map { |square| square.borders.values }.flatten.each do |l|
      next if (l.origin.x.zero? && l.limit.x.zero?) || (l.origin.y.zero? && l.limit.y.zero?)

      painter.draw_line(l.origin.x.to_i, l.origin.y.to_i, l.limit.x.to_i, l.limit.y.to_i)
    end
  end

  private def draw_texts(painter : Qt::Painter)
    painter.pen = Qt::Color.new(@config.colors[:font])

    @grid.squares.each_with_index do |square, index|
      text = @config.keybindings.square_key(index)

      label = Geometry::Label.new(square, text[0..1])

      painter.font.point_size = label.size.to_i / @display.scale_factor

      painter.draw_text(Qt::Point.new(label.origin.x, label.origin.y), label.content)
    end
  end
end
