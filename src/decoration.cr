class Decoration
  def initialize(@border_color_code : Array(UInt32), @square_keys : Array(String)); end

  def border_color
    red, green, blue, alpha = @border_color_code

    SF::Color.new(red, green, blue, alpha)
  end

  def label(id)
    @square_keys[id].to_s
  end
end
