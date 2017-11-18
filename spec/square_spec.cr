require "spec"
require "../src/square"

describe "Square" do
  it "has given origin" do
    origin = Position.new(1_u32, 1_u32)

    Square.new(10_u32, 10_u32, origin: origin).origin.should eq(origin)
  end

  context "when no origin is given" do
    it "has default origin" do
      Square.new(10_u32, 10_u32).origin.should eq(Position.default)
    end
  end

  describe "#to_grid" do
    it "returns a grid with same size and origin" do
      square = Square.new(10_u32, 10_u32, origin: Position.new(50_u32, 40_u32))

      expected_grid = Grid.new(10_u32, 10_u32, origin: Position.new(50_u32, 40_u32))

      square.to_grid.should eq(expected_grid)
    end
  end
end
