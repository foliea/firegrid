require "qt5"

class Firegrid::Display < Qt::DesktopWidget
  private BACKGROUND_FILENAME = "/tmp/firegrid.png"
  private DEFAULT_DPI         =    96
  private DEFAULT_GRAB_ID     = 0_u32

  @mouse_location : Geometry::Position

  def initialize(*args)
    super(*args)

    @mouse_location = fetch_mouse_location
  end

  def scale_factor : Int32
    current_screen.logical_dots_per_inch.to_i / DEFAULT_DPI
  end

  def origin : Geometry::Position
    Geometry::Position.new(geometry.x.to_u32, geometry.y.to_u32)
  end

  def width : UInt32
    geometry.width.to_u32
  end

  def height : UInt32
    geometry.height.to_u32
  end

  def capture : String
    current_screen.grab_window(DEFAULT_GRAB_ID).save(BACKGROUND_FILENAME)

    BACKGROUND_FILENAME
  end

  def click(position : Geometry::Position)
    x = origin.x + position.x
    y = origin.y + position.y

    Process.run("xdotool mousemove #{x} #{y} click 1", shell: true)
  end

  private def geometry
    current_screen.geometry
  end

  private def current_screen
    Qt::GuiApplication.screens.find do |screen|
      geometry = screen.geometry

      top_left_corner = Geometry::Position.new(geometry.x.to_u32, geometry.y.to_u32)

      bottom_right_corner = Geometry::Position.new(
        (geometry.x + geometry.width).to_u32, (geometry.y + geometry.height).to_u32
      )
      @mouse_location.inner?(top_left_corner, bottom_right_corner)
    end.not_nil!
  end

  # This a stopgap which must be removed when the following pull request is merged:
  # https://github.com/Papierkorb/qt5.cr/pull/7
  private def fetch_mouse_location
    io = IO::Memory.new

    Process.run("xdotool getmouselocation", shell: true, output: io)

    full = io.to_s.split(" ")

    Geometry::Position.new(full[0].gsub("x:", "").to_u32, full[1].gsub("y:", "").to_u32)
  end
end
