require "./background"
require "./grid"
require "./ui"
require "./window"

module Application
  # TODO: Resolve resolution dynamically with xrandr lib
  WIDTH  = 3200_u32
  HEIGHT = 1800_u32

  def self.main
    # TODO: Capture screen and use the image
    background = Background.new("/tmp/firegrid.png")

    grid = Grid.new(WIDTH, HEIGHT)

    ui = UI.new(background, grid)

    Window.new(WIDTH, HEIGHT, ui: ui).open
  end
end

Application.main
