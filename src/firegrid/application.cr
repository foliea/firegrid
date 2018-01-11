require "qt5"
require "./settings/config"

class Firegrid::Application < Qt::Application
  def initialize(*args)
    super(*args)

    @window = Window.new(Display.new, Settings::Config.load)
  end

  def self.launch
    new.launch
  end

  def launch
    @window.show

    self.class.exec
  end
end
