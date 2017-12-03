require "qt5"
require "./screen"
require "./config"
require "./grid"

class Overlay < Qt::Widget
  def initialize(@screen : Screen, @config : Config, *args)
    super(*args)

    @grid = Grid.new(@screen.width, @screen.height)
  end

  def paint_event(_event)
    Qt::Painter.draw(self) do |painter|
      draw_lines(painter)
      draw_texts(painter)
    end
  end

  def select(square_id)
    square = @grid.squares[square_id]

    return square.center if square.precise_for?(@screen.width, @screen.height)

    @grid = square.to_grid.resize_for(@screen.width, @screen.height)

    repaint
  end

  private def draw_lines(painter)
    painter.pen = Qt::Color.new(@config.border_color)

    @grid.squares.map { |square| square.borders.values }.flatten.each do |l|
      painter.draw_line(l.origin.x.to_i, l.origin.y.to_i, l.end.x.to_i, l.end.y.to_i)
    end
  end

  private def draw_texts(painter)
    painter.pen = Qt::Color.new(@config.font_color)

    @grid.squares.map { |square| square.label }.each_with_index do |text, square_id|
      painter.font.point_size = text.size.to_i

      painter.draw_text(Qt::Point.new(text.origin.x, text.origin.y), text_label(square_id))
    end
  end

  private def text_label(id)
    @config.keybindings.square_key(id)
  end
end
