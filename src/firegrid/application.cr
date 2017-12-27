require "qt5"

class Firegrid::Application < Qt::Application
  def initialize(*args)
    super(*args)

    @window = Window.new
  end

  def self.launch
    new.launch
  end

  def launch
    @window.show

    self.class.exec
  end
end
