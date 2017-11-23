require "crsfml"

# TODO: move this in UI, unecessary object here
class Background
  @sprite : SF::Sprite

  getter :sprite

  # Todo add color code
  def initialize(@filename : String)
    @sprite = create_sprite
  end

  private def create_sprite
    SF::Sprite.new(texture).tap do |sprite|
      sprite.origin = SF.vector2(0, 0)
      sprite.scale = SF.vector2(1, 1)
      sprite.position = SF.vector2(0, 0)
    end
  end

  private def texture
    SF::Texture.from_file(@filename)
  end
end
