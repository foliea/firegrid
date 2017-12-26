require "qt5"
require "./display"
require "./overlay"

class Window < Qt::MainWindow
  private TITLE = "Firegrid"
  private STATE = Qt::WindowStates::WindowFullScreen

  def initialize(@display = Display.new, @config = Config.load, *args)
    super(*args)

    @overlay = Overlay.new(@display, @config)

    self.window_state = STATE
    self.window_title = TITLE
    self.central_widget = @overlay
    self.fixed_width = @display.width.to_i
    self.fixed_height = @display.height.to_i
    self.style_sheet = "background-image: url(#{@display.capture});"
  end

  def key_press_event(event)
    return close if @config.keybindings.exit_key?(event.text)

    selection = attempt_selection(event.text)

    close_then_click(selection) if selection
  end

  def close_then_click(selection)
    close

    @display.click(selection)
  end

  def resize_event(_event)
    show_full_screen
  end

  def leave_event(_event)
    close
  end

  private def attempt_selection(key)
    return unless @config.keybindings.square_key?(key)

    target_id = @config.keybindings.square_id(key)

    @overlay.select(target_id)
  end
end
