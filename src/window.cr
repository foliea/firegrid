require "crsfml"
require "./grid"

class Window
  TITLE           = "Firegrid"
  FRAMERATE_LIMIT = 60

  def initialize(@width : UInt32, @height : UInt32, @ui : UI)
    @window = SF::RenderWindow.new(SF::VideoMode.new(@width, @height), TITLE, SF::Style::Fullscreen)

    @window.vertical_sync_enabled = true

    @window.framerate_limit = FRAMERATE_LIMIT
  end

  def open
    while @window.open?
      watch_events

      @window.clear(@ui.background_color)

      @window.draw(@ui.background_image)

      @ui.lines.each do |line|
        @window.draw(line, SF::Lines)
      end

      @ui.texts.each do |text|
        @window.draw(text)
      end

      @window.display
    end
  end

  def close
    @window.close
  end

  private def watch_events
    while event = @window.poll_event
      case event
      when SF::Event::Closed
        close
      when SF::Event::KeyPressed
        close if event.code.escape?

        @ui = @ui.select_square(event.code.to_s.downcase)
      end
    end
  end
end
