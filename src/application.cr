require "./screen"
require "./background"
require "./ui"
require "./window"

module Application
  def self.main
    screen = Screen.new

    background = Background.new(screen.capture)

    grid = Grid.new(screen.width, screen.height)

    ui = UI.new(background, grid, config: Config.new)

    Window.new(screen.width, screen.height, ui: ui).open
  end
end

Application.main
