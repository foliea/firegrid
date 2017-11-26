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
    @config = Config.default

    @display = Display.new
  end

  def launch
    Window.new(@display, background: background, keybindings: @config.keybindings, ui: ui).wait
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
    UI.new(@config.font, grid)
  end
end

Application.main
