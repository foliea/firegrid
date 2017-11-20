require "crsfml"
require "./background"
require "./config"
require "./grid"

class UI
  @lines : Array(Array(SF::Vertex))

  getter :lines

  def initialize(@background : Background, @grid : Grid, @config = Config.new)
    @lines = generate_lines(@grid)
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

    UI.new(@background, @grid.squares[id].to_grid)
  end

  private def generate_lines(grid : Grid)
    lines = Array(Array(SF::Vertex)).new

    grid.squares.each do |square|
      lines.concat(square_lines(square))
    end

    lines
  end

  private def square_lines(square : Square)
    [
      [
        SF::Vertex.new(SF.vector2(square.origin.x, square.origin.y)),
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y)),
      ],
      [
        SF::Vertex.new(SF.vector2(square.origin.x, square.origin.y)),
        SF::Vertex.new(SF.vector2(square.origin.x, square.origin.y + square.height)),
      ],
      [
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y)),
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y + square.height)),
      ],
      [
        SF::Vertex.new(SF.vector2(square.origin.x, square.origin.y + square.height)),
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y + square.height)),
      ],
    ]
  end
end
