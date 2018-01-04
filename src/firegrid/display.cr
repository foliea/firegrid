require "qt5"
require "./geometry/position"

class Firegrid::Display < Qt::DesktopWidget
  private BACKGROUND_FILENAME = "/tmp/firegrid.png"
  private DEFAULT_DPI         = 96

  @mouse_location : Geometry::Position

  def initialize(*args)
    super(*args)

    @mouse_location = fetch_mouse_location
  end

  def scale_factor
    current_screen.logical_dots_per_inch.to_i / DEFAULT_DPI
  end

  def position
    Geometry::Position.new(geometry.x.to_u32, geometry.y.to_u32)
  end

  def width
    geometry.width.to_u32
  end

  def height
    geometry.height.to_u32
  end

  def capture
    current_screen.grab_window(current_screen_number.to_u32).save(BACKGROUND_FILENAME)

    BACKGROUND_FILENAME
  end

  def click(position : Geometry::Position)
    Process.run("xdotool mousemove #{position.x} #{position.y} click 1", shell: true)
  end

  private def geometry
    current_screen.geometry
  end

  private def current_screen
    Qt::GuiApplication.screens[current_screen_number]
  end

  private def current_screen_number
    geometries = Qt::GuiApplication.screens.map { |s| s.geometry }

    geometry = geometries.find do |geometry|
      top_left_corner = Geometry::Position.new(geometry.x.to_u32, geometry.y.to_u32)

      bottom_right_corner = Geometry::Position.new(
        (geometry.x + geometry.width).to_u32, (geometry.y + geometry.height).to_u32
      )
      @mouse_location.between?(top_left_corner, bottom_right_corner)
    end

    geometries.index(geometry).as(Int32)
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
