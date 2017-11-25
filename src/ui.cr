require "crsfml"
require "./background"
require "./keybindings"
require "./grid"

class UI
  private MIN_SIZE = 75

  @lines : Array(Array(SF::Vertex))
  @texts : Array(SF::Text)

  getter :lines, :texts

  def initialize(@background : Background,
                 @font : Font,
                 @grid : Grid)
    color = SF::Color::Red
    @lines = generate_lines(@grid)
    @texts = generate_texts(@grid)
  end

  def background_image
    @background.sprite
  end

  def focus(square_id)
    UI.new(@background, @font, square(square_id).to_grid)
  end

  def square(id)
    @grid.squares[id]
  end

  def too_small?
    @grid.width <= MIN_SIZE || @grid.height <= MIN_SIZE
  end

  private def generate_texts(grid : Grid)
    @grid.squares.map_with_index do |square, square_id|
      SF::Text.new.tap do |text|
        text.position = {square.center.x, square.center.y}
        text.color = SF::Color::Red
        text.font = @font.object
        text.string = square_id.to_s
        text.character_size = @font.size
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
    color = SF::Color::Red
    [
      [
        SF::Vertex.new(SF.vector2(x, y), color),
        SF::Vertex.new(SF.vector2(x + square.width, y), color),
      ],
      [
        SF::Vertex.new(SF.vector2(x, y), color),
        SF::Vertex.new(SF.vector2(x, y + square.height), color),
      ],
      [
        SF::Vertex.new(SF.vector2(x + square.width, y), color),
        SF::Vertex.new(SF.vector2(x + square.width, y + square.height), color),
      ],
      [
        SF::Vertex.new(SF.vector2(x, y + square.height), color),
        SF::Vertex.new(SF.vector2(x + square.width, y + square.height), color),
      ],
    ]
  end
end
