# TODO: Load width and height with xrandr, capture with some tool
class Screen
  def width
    3200_u32
  end

  def height
    1800_u32
  end

  def capture
    "/tmp/firegrid.png"
  end
end
