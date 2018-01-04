require "../spec_helper"

describe "Position" do
  describe ".default" do
    it "returns a position with default x" do
      Position.default.x.should eq(0_u32)
    end

    it "returns a position with default y" do
      Position.default.y.should eq(0_u32)
    end
  end

  describe "#between?" do
    point_a = Position.new(0_u32, 1_u32)
    point_b = Position.new(10_u32, 5_u32)

    it { Position.new(12_u32, 10_u32).between?(point_a, point_b).should be_false }

    context "when position is between point a and point b" do
      it { Position.new(1_u32, 1_u32).between?(point_a, point_b).should be_true }
    end
  end

  describe "==" do
    it { (Position.new(0_u32, 0_u32) == Position.new(1_u32, 1_u32)).should be_false }

    context "when given position has the same x value" do
      it { (Position.new(0_u32, 0_u32) == Position.new(0_u32, 1_u32)).should be_false }
    end

    context "when given position has the same y value" do
      it { (Position.new(0_u32, 0_u32) == Position.new(1_u32, 0_u32)).should be_false }
    end

    context "when given position has the same x and y values" do
      it { (Position.new(0_u32, 0_u32) == Position.new(0_u32, 0_u32)).should be_true }
    end
  end
end
