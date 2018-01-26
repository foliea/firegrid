require "qt5"
require "./geometry/label"

class Firegrid::Overlay < Qt::Widget
  def initialize(@panel : Geometry::Panel, @config : Settings::Config, *args)
    super(*args)
  end

  def paint_event(_event)
    Qt::Painter.draw(self) do |painter|
      draw_lines(painter)
      draw_texts(painter)
    end
  end

  private def draw_lines(painter)
    painter.pen = Qt::Color.new(@config.colors[:border])

    @panel.borders.each do |b|
      next if (b.origin.x.zero? && b.limit.x.zero?) || (b.origin.y.zero? && b.limit.y.zero?)

      painter.draw_line(b.origin.x, b.origin.y, b.limit.x, b.limit.y)
    end
  end

  private def draw_texts(painter)
    painter.pen = Qt::Color.new(@config.colors[:font])

    @panel.labels(@config.tile_keys).each do |label|
      painter.font.pixel_size = label.size

      painter.draw_text(Qt::Point.new(label.origin.x, label.origin.y), label.content)
    end
  end
end
