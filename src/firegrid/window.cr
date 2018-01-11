require "qt5"
require "./settings/config"
require "./geometry/panel"

class Firegrid::Window < Qt::MainWindow
  private TITLE = "Firegrid"
  private STATE = Qt::WindowStates::WindowFullScreen

  @keybindings : Settings::Keybindings

  def initialize(@display = Display.new, config = Settings::Config.load, *args)
    super(*args)

    @panel = Geometry::Panel.new(@display.width, @display.height, config.max_grid_size)

    @overlay = Overlay.new(@panel.grid, config, @display.scale_factor)

    @keybindings = config.keybindings

    configure
  end

  def key_press_event(event)
    keycode = event.text

    return close if @keybindings.exit_keycode?(keycode)

    choose(@keybindings.square_id(keycode)) if @keybindings.square_keycode?(keycode)
  end

  def resize_event(_event)
    move(@display.origin.x.to_i, @display.origin.y.to_i)

    resize(@display.width.to_i, @display.height.to_i)

    show_full_screen
  end

  def leave_event(_event)
    close
  end

  private def choose(square_id : Int32)
    status, selection = @panel.select(square_id)

    return close_then_click(selection.not_nil!) if status == :clickable

    @overlay.refresh(@panel.grid)
  end

  private def close_then_click(selection : Geometry::Position)
    close

    @display.click(selection)
  end

  private def configure
    self.window_state = STATE
    self.window_title = TITLE
    self.central_widget = @overlay
    self.fixed_width = @display.width.to_i
    self.fixed_height = @display.height.to_i
    self.style_sheet = "background-image: url(#{@display.capture});"
  end
end
