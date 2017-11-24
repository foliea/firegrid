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
                 @keybindings : Keybindings,
                 @grid : Grid)
    @lines = generate_lines(@grid)
    @texts = generate_texts(@grid)
  end

  def background_image
    @background.sprite
  end

  def known_key?(keycode : String)
    @keybindings.square_key?(keycode)
  end

  def press_key(keycode : String)

    UI.new(@background, @font, @keybindings, selected_square(keycode).to_grid)
  end

  def selection(keycode : String)
    selected_square(keycode).center
  end

  def too_small?
    @grid.width <= MIN_SIZE || @grid.height <= MIN_SIZE
  end

  private def selected_square(keycode)
    id = @keybindings.square_id(keycode).as(Int32)

    @grid.squares[id]
  end

  private def generate_texts(grid : Grid)
    @grid.squares.map do |square|
      id = @grid.squares.index(square).as(Int32)

      SF::Text.new.tap do |text|
        text.position = {square.center.x, square.center.y}
        text.font = @font.object
        text.string = @keybindings.square_key(id)
        text.character_size = @font.size
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
