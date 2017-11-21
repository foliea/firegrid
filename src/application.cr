require "./display"
require "./background"
require "./ui"
require "./window"

module Application
  def self.main
    display = Display.new

    background = Background.new(display.capture)

    grid = Grid.new(display.width, display.height)

    ui = UI.new(background, grid, config: Config.new)

    Window.new(display.width, display.height, ui: ui).open

    display.close
  end
end

Application.main
