require "./config"
require "./display"
require "./background"
require "./ui"
require "./window"

class Application
  def self.main
    application = new
    application.launch
    application.clean
  end

  def initialize
    @config = Config.new

    @display = Display.new
  end

  def launch
    Window.new(@display.width, @display.height, ui: ui).open
  end

  def clean
    @display.close
  end

  private def background
    Background.new(@display.capture)
  end

  private def grid
    Grid.new(@display.width, @display.height)
  end

  private def ui
    UI.new(background, @config.font, @config.keybindings, grid)
  end
end

Application.main
