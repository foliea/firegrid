require "./spec_helper"
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

  describe "#selectable?" do
    grid = Grid.new(5_u32, 5_u32, max_size: 10_u32)

    it { grid.selectable?(8).should be_true }

    context "when square id doesn't match an existing square" do
      it { grid.selectable?(9).should be_false }
    end
  end

  describe "#resize_for" do
    grid = Grid.new(10_u32, 10_u32, origin: Position.new(0_u32, 0_u32))

    it "returns the original grid" do
      grid.resize_for(20_u32, 20_u32).should eq(grid)
    end

    context "when grid width is below precision rate of given width" do
      it "returns a new grid with a lower max size" do
        grid.resize_for(400_u32, 20_u32).max_size.should eq(4_u32)
      end
    end

    context "when grid height is below precision rate of given height" do
      it "returns a new grid with a lower max size" do
        grid.resize_for(20_u32, 400_u32).max_size.should eq(4_u32)
      end
    end
  end

  describe "#squares" do
    it "creates and return grid squares" do
      grid = Grid.new(1920_u32, 1200_u32, max_size: 6_u32)

      grid.squares.should eq([
        Square.new(640_u32, 600_u32, origin: Position.new(0_u32, 0_u32)),
        Square.new(640_u32, 600_u32, origin: Position.new(640_u32, 0_u32)),
        Square.new(640_u32, 600_u32, origin: Position.new(1280_u32, 0_u32)),
        Square.new(640_u32, 600_u32, origin: Position.new(0_u32, 600_u32)),
        Square.new(640_u32, 600_u32, origin: Position.new(640_u32, 600_u32)),
        Square.new(640_u32, 600_u32, origin: Position.new(1280_u32, 600_u32)),
      ])
    end
  end

  describe "==" do
    position = Position.new(1_u32, 1_u32)

    grid = Grid.new(0_u32, 0_u32, origin: position)

    it { (grid == Grid.new(1_u32, 1_u32, origin: Position.new(2_u32, 2_u32))).should be_false }

    context "when given grid has the same width and origin values" do
      it { (grid == Grid.new(0_u32, 1_u32, origin: position)).should be_false }
    end

    context "when given grid has the same height and width values" do
      it { (grid == Grid.new(1_u32, 0_u32, origin: position)).should be_false }
    end

    context "when given origin has the same width, height, and origin values" do
      it { (grid == Grid.new(0_u32, 0_u32, origin: position)).should be_true }
    end
  end
end
