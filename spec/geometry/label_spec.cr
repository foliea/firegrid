require "../spec_helper"

describe "Label" do
  square = Square.new(50_u32, 50_u32, origin: Position.new(100_u32, 120_u32))

  describe "#size" do
    it "returns the calculated size from given square" do
      Label.new(square, "a").size.should eq(25_u32)
    end
  end

  describe "#origin" do
    it "returns the calculated origin from given square" do
      Label.new(square, "a").origin.should eq(Position.new(113_u32, 157_u32))
    end
  end
end
