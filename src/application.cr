require "qt5"
require "./window"

class Application < Qt::Application
  def initialize(*args)
    super(*args)

    @window = Window.new
  end

  def open_window
    @window.show
  end
end

Application.new.open_window

Application.exec
