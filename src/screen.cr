require "qt5"

class Screen < Qt::DesktopWidget
  private BACKGROUND_FILENAME = "/tmp/firegrid.png"
  private DEFAULT_DPI         = 96

  def scale_factor
    current_screen.logical_dots_per_inch.to_i / DEFAULT_DPI
  end

  def width
    geometry.width.to_u32
  end

  def height
    geometry.height.to_u32
  end

  def capture
    current_screen.grab_window(0_u32).save(BACKGROUND_FILENAME)

    BACKGROUND_FILENAME
  end

  def click(position : Position)
    Process.run("xdotool mousemove #{position.x} #{position.y} click 1", shell: true)
  end

  private def geometry
    screen_geometry(primary_screen)
  end

  private def current_screen
    Qt::GuiApplication.primary_screen
  end
end
