require "crsfml"
require "./background"
require "./keybindings"
require "./grid"

class UI
  @lines : Array(Array(SF::Vertex))
  @texts : Array(SF::Text)

  getter :lines, :texts

  def initialize(@background : Background,
                 @font : Font,
                 @keybindings : Keybindings,
                 @grid : Grid)
    @lines = generate_lines(@grid)
    @texts = generate_texts(@grid)
  end

  def background_image
    @background.sprite
  end

  def press_key(keycode : String)
    return self unless @keybindings.square_key?(keycode)

    id = @keybindings.square_id(keycode).as(Int32)

    UI.new(@background, @font, @keybindings, @grid.squares[id].to_grid)
  end

  private def generate_texts(grid : Grid)
    @grid.squares.map do |square|
      id = @grid.squares.index(square).as(Int32)

      SF::Text.new.tap do |text|
        text.position = {square.center.x, square.center.y}
        text.font = @font.object
        text.string = @keybindings.square_key(id)
        text.character_size = (square.width * 0.3).to_i
      end
    end
  end

  private def generate_lines(grid : Grid)
    lines = Array(Array(SF::Vertex)).new

    grid.squares.each do |square|
      lines.concat(square_lines(square))
    end

    lines
  end

  private def square_lines(square : Square)
    x = square.origin.x.zero? ? 1 : square.origin.x
    y = square.origin.y.zero? ? 1 : square.origin.y
    [
      [
        SF::Vertex.new(SF.vector2(x, y)),
        SF::Vertex.new(SF.vector2(x + square.width, y)),
      ],
      [
        SF::Vertex.new(SF.vector2(x, y)),
        SF::Vertex.new(SF.vector2(x, y + square.height)),
      ],
      [
        SF::Vertex.new(SF.vector2(x + square.width, y)),
        SF::Vertex.new(SF.vector2(x + square.width, y + square.height)),
      ],
      [
        SF::Vertex.new(SF.vector2(x, y + square.height)),
        SF::Vertex.new(SF.vector2(x + square.width, y + square.height)),
      ],
    ]
  end
end
