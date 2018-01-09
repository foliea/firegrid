require "qt5"
require "./settings/config"

class Firegrid::Window < Qt::MainWindow
  private TITLE = "Firegrid"
  private STATE = Qt::WindowStates::WindowFullScreen

  def initialize(@display = Display.new, @config = Settings::Config.load, *args)
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
    return close if @config.keybindings.exit_keycode?(event.text)

    attempt_selection(event.text)
  end

  def close_then_click(selection : Geometry::Position)
    close

    @display.click(selection)
  end

  def resize_event(_event)
    move(@display.origin.x.to_i, @display.origin.y.to_i)

    resize(@display.width.to_i, @display.height.to_i)

    show_full_screen
  end

  def leave_event(_event)
    close
  end

  private def attempt_selection(keycode : String)
    return unless @config.keybindings.square_keycode?(keycode)

    square_id = @config.keybindings.square_id(keycode)

    status, selection = @overlay.select(square_id)

    close_then_click(selection.not_nil!) if status == :clickable
  end
end
