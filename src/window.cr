require "crsfml"
require "./grid"

class Window
  private STYLE           = SF::Style::Fullscreen
  private COLOR           = SF::Color::Transparent
  private TITLE           = "Firegrid"
  private FRAMERATE_LIMIT = 60

  def initialize(@display : Display, @background : Background, @keybindings : Keybindings, @ui : UI)
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

    @window.draw(@background.sprite)

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

      target = @ui.targets[@keybindings.square_id(keycode)]

      if target.precise_for?(@display.width, @display.height)
        return close_and_click(target.center)
      end

      @ui = @ui.focus(target.to_grid)
    end
  end

  private def close_and_click(selection : Position)
    close

    @display.click(selection)
  end

  private def close
    @window.close
  end
end
