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
      font_size = (square.width < square.height ? square.width : square.height) / 2

      SF::Text.new.tap do |text|
        text.position = {square.center.x - font_size / 2.0, square.center.y - font_size / 2.0}
        text.color = @font.color
        text.font = @font.to_sf_font
        text.string = @decoration.label(square_id)
        text.character_size = font_size
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
    x = square.origin.x.zero? ? 1 : square.origin.x
    y = square.origin.y.zero? ? 1 : square.origin.y
    [
      [
        SF::Vertex.new(SF.vector2(x, y), @decoration.border_color),
        SF::Vertex.new(SF.vector2(x + square.width, y), @decoration.border_color),
      ],
      [
        SF::Vertex.new(SF.vector2(x, y), @decoration.border_color),
        SF::Vertex.new(SF.vector2(x, y + square.height), @decoration.border_color),
      ],
      [
        SF::Vertex.new(SF.vector2(x + square.width, y), @decoration.border_color),
        SF::Vertex.new(SF.vector2(x + square.width, y + square.height), @decoration.border_color),
      ],
      [
        SF::Vertex.new(SF.vector2(x, y + square.height), @decoration.border_color),
        SF::Vertex.new(SF.vector2(x + square.width, y + square.height), @decoration.border_color),
      ],
    ]
  end
end
