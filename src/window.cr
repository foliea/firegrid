require "crsfml"
require "./grid"

class Window

  TITLE = "Firegrid"

  def initialize(@width : UInt32, @height : UInt32, @ui : UI)
    @window = SF::RenderWindow.new(SF::VideoMode.new(@width, @height), TITLE)

    @window.vertical_sync_enabled = true

    @window.framerate_limit = 60
  end

  def open
    while @window.open?
      watch_events

      @window.clear(@ui.background_color)

      @window.draw(@ui.background_image)

      @ui.lines.each do |line|
        @window.draw(line, SF::Lines)
      end

      @window.display()
    end
  end

  private def watch_events
    while event = @window.poll_event()
      if event.is_a?(SF::Event::Closed)
        @window.close
      end
    end
  end

end
