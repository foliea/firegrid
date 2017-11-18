require "spec"
require "../src/grid"

describe "Grid" do
  it "has given origin" do
    origin = Position.new(1_u32, 1_u32)

    Grid.new(10_u32, 10_u32, origin: origin).origin.should eq(origin)
  end

  context "when no origin is given" do
    it "has default origin" do
      Grid.new(10_u32, 10_u32).origin.should eq(Position.default)
    end
  end

  describe "#center" do
    it "returns grid center origin" do
      grid = Grid.new(200_u32, 240_u32, origin: Position.new(100_u32, 120_u32))

      grid.center.should eq(Position.new(150_u32, 180_u32))
    end
  end

  describe "==" do
    it { (Grid.new(0_u32, 0_u32) == Grid.new(1_u32, 1_u32)).should be_false }

    context "when given origin has the same x value" do
      it { (Grid.new(0_u32, 0_u32) == Grid.new(0_u32, 1_u32)).should be_false }
    end

    context "when given origin has the same y value" do
      it { (Grid.new(0_u32, 0_u32) == Grid.new(1_u32, 0_u32)).should be_false }
    end

    context "when given origin has the same x, y, and origin values" do
      it { (Grid.new(0_u32, 0_u32) == Grid.new(0_u32, 0_u32)).should be_true }
    end
  end
end
