require "../spec_helper"

describe Grid do
  it "has given origin" do
    origin = Position.new(1_u32, 1_u32)

    Grid.new(10_u32, 10_u32, origin: origin, max_size: 4_u32).origin.should eq(origin)
  end

  context "when no origin is given" do
    it "has default origin" do
      Grid.new(10_u32, 10_u32, max_size: 4_u32).origin.should eq(Position.default)
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

    grid = Grid.new(0_u32, 0_u32, origin: position, max_size: 4_u32)

    it do
      other_grid = Grid.new(1_u32, 1_u32, origin: Position.new(2_u32, 2_u32), max_size: 2_u32)

      (grid == other_grid).should be_false
    end

    context "when given grid has the same width and origin values" do
      it { (grid == Grid.new(0_u32, 1_u32, origin: position, max_size: 2_u32)).should be_false }
    end

    context "when given grid has the same height and width values" do
      it { (grid == Grid.new(1_u32, 0_u32, origin: position, max_size: 2_u32)).should be_false }
    end

    context "when given origin has the same width, height, and origin values" do
      it { (grid == Grid.new(0_u32, 0_u32, origin: position, max_size: 2_u32)).should be_false }
    end
    context "when given origin has the same width, height, origin and max size values" do
      it { (grid == Grid.new(0_u32, 0_u32, origin: position, max_size: 4_u32)).should be_true }
    end
  end
end
