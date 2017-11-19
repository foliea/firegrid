require "./background"
require "./grid"
require "./ui"
require "./window"

module Application

  def self.main
    # TODO: Capture screen and use the image
    background = Background.new("images/background.png")

    grid = Grid.new(3200_u32, 1800_u32)

    ui = UI.new(background, grid)

    # TODO: Resolve resolution dynamically with xrandr lib
    Window.new(3200_u32, 1800_u32, ui: ui).open
  end

end

Application.main
