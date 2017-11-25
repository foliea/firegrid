require "crsfml"
require "./grid"

class Window
  private STYLE           = SF::Style::Fullscreen
  private COLOR           = SF::Color::Transparent
  private TITLE           = "Firegrid"
  private FRAMERATE_LIMIT = 60

  def initialize(@display : Display, @keybindings : Keybindings, @ui : UI)
    mode = SF::VideoMode.new(@display.width, @display.height)

    @window = SF::RenderWindow.new(mode, TITLE, STYLE)

    @window.vertical_sync_enabled = true

    @window.framerate_limit = FRAMERATE_LIMIT
  end

  def wait
    while @window.open?
      while event = @window.poll_event
        handle_event(event)
      end
      draw
    end
  end

  private def draw
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

  private def handle_event(event : SF::Event)
    case event
    when SF::Event::Closed
      close
    when SF::Event::KeyPressed
      keycode = event.code.to_s.downcase

      return close unless @keybindings.square_key?(keycode)

      square_id = @keybindings.square_id(keycode)

      return close(@ui.square(square_id).center) if @ui.too_small?

      @ui = @ui.focus(square_id)
    end
  end

  private def close(selection : Position)
    close

    @display.click(selection) if selection
  end

  private def close
    @window.close
  end
end
