require "crsfml"
require "./background"
require "./grid"

class UI

  @lines : Array(Array(SF::Vertex))

  getter :lines

  def initialize(@background : Background, @grid : Grid)
    @lines = generate_lines(@grid)
  end

  def background_color
    @background.color
  end

  def background_image
    @background.sprite
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
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y))
      ],
      [
        SF::Vertex.new(SF.vector2(square.origin.x, square.origin.y)),
        SF::Vertex.new(SF.vector2(square.origin.x, square.origin.y + square.height))
      ],
      [
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y)),
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y + square.height))
      ],
      [
        SF::Vertex.new(SF.vector2(square.origin.x, square.origin.y + square.height)),
        SF::Vertex.new(SF.vector2(square.origin.x + square.width, square.origin.y + square.height))
      ]
    ]
  end

end
