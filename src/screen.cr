# TODO: Load width and height with xrandr, capture with some tool
class Screen
  def width
    2560_u32
  end

  def height
    1080_u32
  end

  def capture
    "/tmp/firegrid.png"
  end
end
