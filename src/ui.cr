require "crsfml"
require "./background"
require "./config"
require "./grid"

class UI
  @lines : Array(Array(SF::Vertex))
  @texts : Array(SF::Text)

  getter :lines, :texts

  def initialize(@background : Background, @grid : Grid, @config : Config)
    # TODO: move this elsewhere, avoid to load it multiple times
    @font = SF::Font.from_file(@config.font_file)

    @lines = generate_lines(@grid)
    @texts = generate_texts(@grid)
  end

  def background_color
    @background.color
  end

  def background_image
    @background.sprite
  end

  def select_square(keycode : String)
    return self unless @config.square_key?(keycode)

    id = @config.square_id(keycode).as(Int32)

    return self unless id < @grid.squares.size

    UI.new(@background, @grid.squares[id].to_grid, @config)
  end

  private def generate_texts(grid : Grid)
    @grid.squares.map do |square|
      id = @grid.squares.index(square).as(Int32)

      SF::Text.new.tap do |text|
        text.position = { square.center.x, square.center.y }
        text.font = @font
        text.string = @config.square_key(id)
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
