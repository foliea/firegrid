require "x11"

class Display
  private FILENAME = "/tmp/firegrid.png"

  def initialize
    @display = X11::C::X.open_display(nil)
  end

  def close
    X11::C::X.close_display(@display)
  end

  def width
    X11::C::X.display_width(@display, current_screen).to_u32
  end

  def height
    X11::C::X.display_height(@display, current_screen).to_u32
  end

  def capture
    Process.run("wscrot -e 'mv $f #{FILENAME}'")

    FILENAME
  end

  private def current_screen
    X11::C::X.default_screen(@display)
  end
end
