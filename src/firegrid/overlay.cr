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

  def select(square_id)
    return unless @grid.selectable?(square_id)

    square = @grid.squares[square_id]

    return square.center if square.precise_for?(@display.width, @display.height)

    @grid = square.to_grid.resize_for(@display.width, @display.height)

    repaint
  end

  private def draw_lines(painter)
    painter.pen = Qt::Color.new(@config.colors["border"])

    @grid.squares.map { |square| square.borders.values }.flatten.each do |l|
      next if (l.origin.x.zero? && l.end.x.zero?) || (l.origin.y.zero? && l.end.y.zero?)

      painter.draw_line(l.origin.x.to_i, l.origin.y.to_i, l.end.x.to_i, l.end.y.to_i)
    end
  end

  private def draw_texts(painter)
    painter.pen = Qt::Color.new(@config.colors["font"])

    @grid.squares.map { |square| square.label }.each_with_index do |text, square_id|
      painter.font.point_size = text.size.to_i / @display.scale_factor

      painter.draw_text(Qt::Point.new(text.origin.x, text.origin.y), text_label(square_id))
    end
  end

  private def text_label(id)
    @config.keybindings.square_key(id)
  end
end
