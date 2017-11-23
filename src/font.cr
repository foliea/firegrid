require "crsfml"

class Font
  def initialize(filename)
    @font = SF::Font.from_file(filename)
  end

  def object
    @font
  end
end
