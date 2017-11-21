require "spec"
require "../src/square"

describe "Square" do
  it "has given origin" do
    origin = Position.new(1_u32, 1_u32)

    Square.new(10_u32, 10_u32, origin: origin).origin.should eq(origin)
  end

  describe "#center" do
    it "returns square center origin" do
      square = Square.new(50_u32, 50_u32, origin: Position.new(100_u32, 120_u32))

      square.center.should eq(Position.new(125_u32, 145_u32))
    end
  end

  describe "#to_grid" do
    it "returns a grid with same size and origin" do
      origin = Position.new(50_u32, 40_u32)

      square = Square.new(10_u32, 10_u32, origin: origin)

      expected_grid = Grid.new(10_u32, 10_u32, origin: origin)

      square.to_grid.should eq(expected_grid)
    end
  end

  describe "==" do
    position = Position.new(1_u32, 1_u32)

    square = Square.new(0_u32, 0_u32, origin: position)

    it { (square == Square.new(1_u32, 1_u32, origin: Position.new(2_u32, 2_u32))).should be_false }

    context "when given square has the same width and origin values" do
      it { (square == Square.new(0_u32, 1_u32, origin: position)).should be_false }
    end

    context "when given square has the same height and origin values" do
      it { (square == Square.new(1_u32, 0_u32, origin: position)).should be_false }
    end

    context "when given origin has the same width, height, and origin values" do
      it { (square == Square.new(0_u32, 0_u32, origin: position)).should be_true }
    end
  end
end
