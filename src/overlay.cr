require "qt5"
require "./screen"
require "./config"
require "./grid"

class Overlay < Qt::Widget
  def initialize(@screen = Screen.new, @config = Config.default, *args)
    super(*args)

    @grid = Grid.new(@screen.width, @screen.height)
  end

  def paint_event(_event)
    Qt::Painter.draw(self) do |p|
      p.pen = Qt::Color.new(@config.border_color)

      lines.each do |l|
        p.draw_line(l.origin.x.to_i, l.origin.y.to_i, l.end.x.to_i, l.end.y.to_i)
      end

      texts.each_with_index do |t, square_id|
        p.font.point_size = t.size.to_i

        p.draw_text(Qt::Point.new(t.origin.x, t.origin.y), keybindings.square_key(square_id))
      end
    end
  end

  private def lines
    @grid.squares.map { |square| square.borders.values }.flatten
  end

  private def texts
    @grid.squares.map { |square| square.label }
  end

  private def keybindings
    @config.keybindings
  end
end
