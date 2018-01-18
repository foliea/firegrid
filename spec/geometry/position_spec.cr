require "../spec_helper"

describe Position do
  describe ".default" do
    it "returns a position with default x" do
      Position.default.x.should eq(0)
    end

    it "returns a position with default y" do
      Position.default.y.should eq(0)
    end
  end

  describe "#inner?" do
    point_a = Position.new(0, 1)
    point_b = Position.new(10, 5)

    it { Position.new(12, 10).inner?(point_a, point_b).should be_false }

    context "when position is inner point a and point b" do
      it { Position.new(1, 1).inner?(point_a, point_b).should be_true }
    end
  end

  describe "==" do
    it { (Position.new(0, 0) == Position.new(1, 1)).should be_false }

    context "when given position has the same x value" do
      it { (Position.new(0, 0) == Position.new(0, 1)).should be_false }
    end

    context "when given position has the same y value" do
      it { (Position.new(0, 0) == Position.new(1, 0)).should be_false }
    end

    context "when given position has the same x and y values" do
      it { (Position.new(0, 0) == Position.new(0, 0)).should be_true }
    end
  end
end
