require "qt5"
require "./screen"
require "./overlay"

class Window < Qt::MainWindow
  private TITLE = "Firegrid"
  private STATE = Qt::WindowStates::WindowFullScreen

  def initialize(@screen = Screen.new, *args)
    super(*args)

    self.window_state = STATE
    self.window_title = TITLE

    self.central_widget = Overlay.new(@screen)

    self.style_sheet = "background-image: url(#{@screen.capture});"
  end
end
