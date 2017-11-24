require "crsfml"
require "./grid"

class Window
  private TITLE           = "Firegrid"
  private COLOR           = SF::Color::Transparent
  private FRAMERATE_LIMIT = 60

  def initialize(@width : UInt32, @height : UInt32, @ui : UI)
    @window = SF::RenderWindow.new(SF::VideoMode.new(@width, @height), TITLE, SF::Style::Fullscreen)

    @window.vertical_sync_enabled = true

    @window.framerate_limit = FRAMERATE_LIMIT

    @after_close = Proc(Void).new {}
  end

  def open
    while @window.open?
      watch_events

      @window.clear(COLOR)

      @window.draw(@ui.background_image)

      @ui.lines.each do |line|
        @window.draw(line, SF::Lines)
      end

      @ui.texts.each do |text|
        @window.draw(text)
      end

      @window.display
    end
    @after_close.call
  end

  private def close
    @window.close
  end

  private def watch_events
    while event = @window.poll_event
      case event
      when SF::Event::Closed
        close
      when SF::Event::KeyPressed
        keycode = event.code.to_s.downcase

        return close unless @ui.known_key?(keycode)

        if @ui.too_small?
          selection = @ui.selection(keycode)

          @after_close = Proc(Void).new do
            Process.run("xdotool mousemove #{selection.x} #{selection.y} click 1", shell: true)
          end

          close
        end

        @ui = @ui.press_key(keycode)
      end
    end
  end
end
