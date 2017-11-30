require "crsfml"
require "./background"
require "./keybindings"
require "./grid"
require "./decoration"

class UI
  @lines : Array(Array(SF::Vertex))
  @texts : Array(SF::Text)

  getter :lines, :texts

  def initialize(@font : Font, @decoration : Decoration, @grid : Grid)
    @lines = generate_lines(@grid)
    @texts = generate_texts(@grid)
  end

  def focus(grid : Grid)
    self.class.new(@font, @decoration, grid)
  end

  def targets
    @grid.squares
  end

  private def generate_texts(grid : Grid)
    @grid.squares.map_with_index do |square, square_id|
      SF::Text.new.tap do |text|
        text.position = {square.label.origin.x, square.label.origin.y}
        text.color = @font.color
        text.font = @font.to_sf_font
        text.string = @decoration.label(square_id)
        text.character_size = square.label.size
        text.style = SF::Text::Bold
      end
    end
  end

  private def generate_lines(grid : Grid)
    Array(Array(SF::Vertex)).new.tap do |lines|
      grid.squares.each do |square|
        lines.concat(square_lines(square))
      end
    end
  end

  private def square_lines(square : Square)
    square.borders.values.map do |border|
      [
        SF::Vertex.new(SF.vector2(border.origin.x, border.origin.y), @decoration.border_color),
        SF::Vertex.new(SF.vector2(border.end.x, border.end.y), @decoration.border_color),
      ]
    end
  end
end
