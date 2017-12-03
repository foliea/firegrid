require "qt5"
require "./display"
require "./overlay"

class Window < Qt::MainWindow
  private TITLE = "Firegrid"
  private STATE = Qt::WindowStates::WindowFullScreen

  def initialize(@display = Display.new, @config = Config.default, *args)
    super(*args)

    @overlay = Overlay.new(@display, @config)

    self.window_state = STATE
    self.window_title = TITLE

    self.central_widget = @overlay

    self.style_sheet = "background-image: url(#{@display.capture});"
  end

  def key_press_event(event)
    return close unless @config.keybindings.square_key?(event.text)

    target_id = @config.keybindings.square_id(event.text)

    selection = @overlay.select(target_id)

    close_then_click(selection) if selection
  end

  def close_then_click(selection)
    close

    @display.click(selection)
  end
end
