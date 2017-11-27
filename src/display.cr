require "x11"

class Display
  private FILENAME = "/tmp/firegrid.png"

  def initialize
    @display = X11::Display.new
  end

  def close
    @display.close
  end

  def width
    @display.width(current_screen).to_u32
  end

  def height
    @display.height(current_screen).to_u32
  end

  def capture
    Process.run("import -window root -display :0 --screen #{FILENAME}", shell: true)

    FILENAME.gsub(".", "-#{current_screen}.")
  end

  def click(position : Position)
    Process.run("xdotool mousemove #{position.x} #{position.y} click 1", shell: true)
  end

  private def current_screen
    @display.default_screen_number
  end
end
