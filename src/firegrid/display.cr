require "qt5"

class Firegrid::Display < Qt::DesktopWidget
  private BACKGROUND_FILENAME = "/tmp/firegrid.png"
  private DEFAULT_GRAB_ID     = 0_u32

  @mouse_location : Geometry::Position

  def initialize(*args)
    super(*args)

    @mouse_location = fetch_mouse_location
  end

  def origin : Geometry::Position
    Geometry::Position.new(geometry.x, geometry.y)
  end

  def width : Int32
    geometry.width
  end

  def height : Int32
    geometry.height
  end

  def capture : String
    current_screen.grab_window(DEFAULT_GRAB_ID).save(BACKGROUND_FILENAME)

    BACKGROUND_FILENAME
  end

  def click(position : Geometry::Position)
    cmd = "xdotool mousemove #{origin.x + position.x} #{origin.y + position.y} click 1"

    Process.run(cmd, shell: true)
  end

  private def geometry
    current_screen.geometry
  end

  private def current_screen
    Qt::GuiApplication.screens.find do |screen|
      top_left_corner = Geometry::Position.new(screen.geometry.x, screen.geometry.y)

      bottom_right_corner = Geometry::Position.new(
        (screen.geometry.x + screen.geometry.width),
        (screen.geometry.y + screen.geometry.height)
      )
      @mouse_location.inner?(top_left_corner, bottom_right_corner)
    end.not_nil!
  end

  # This is a stopgap which must be removed when the following pull request is merged:
  # https://github.com/Papierkorb/qt5.cr/pull/7
  private def fetch_mouse_location
    io = IO::Memory.new

    Process.run("xdotool getmouselocation", shell: true, output: io)

    full = io.to_s.split(" ")

    Geometry::Position.new(full[0].gsub("x:", "").to_i, full[1].gsub("y:", "").to_i)
  end
end
