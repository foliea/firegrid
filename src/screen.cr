require "qt5"

class Screen < Qt::DesktopWidget
  private BACKGROUND_FILENAME = "/tmp/firegrid.png"

  def width
    geometry.width.to_u32
  end

  def height
    geometry.height.to_u32
  end

  def capture
    Qt::GuiApplication.primary_screen.grab_window(0_u32).save(BACKGROUND_FILENAME)

    BACKGROUND_FILENAME
  end

  def click(position : Position)
    Process.run("xdotool mousemove #{position.x} #{position.y} click 1", shell: true)
  end

  private def geometry
    screen_geometry(primary_screen)
  end
end
