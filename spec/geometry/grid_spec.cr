require "../spec_helper"

describe Grid do
  it "has given origin" do
    origin = Position.new(1, 1)

    Grid.new(10, 10, origin: origin, max_size: 4).origin.should eq(origin)
  end

  context "when no origin is given" do
    it "has default origin" do
      Grid.new(10, 10, max_size: 4).origin.should eq(Position.default)
    end
  end

  describe "#tiles" do
    it "creates and return grid tiles" do
      grid = Grid.new(1920, 1200, max_size: 6)

      grid.tiles.should eq([
        Tile.new(640, 600, origin: Position.new(0, 0)),
        Tile.new(640, 600, origin: Position.new(640, 0)),
        Tile.new(640, 600, origin: Position.new(1280, 0)),
        Tile.new(640, 600, origin: Position.new(0, 600)),
        Tile.new(640, 600, origin: Position.new(640, 600)),
        Tile.new(640, 600, origin: Position.new(1280, 600)),
      ])
    end
  end

  describe "==" do
    position = Position.new(1, 1)

    grid = Grid.new(0, 0, origin: position, max_size: 4)

    it do
      other_grid = Grid.new(1, 1, origin: Position.new(2, 2), max_size: 2)

      (grid == other_grid).should be_false
    end

    context "when given grid has the same width and origin values" do
      it { (grid == Grid.new(0, 1, origin: position, max_size: 2)).should be_false }
    end

    context "when given grid has the same height and width values" do
      it { (grid == Grid.new(1, 0, origin: position, max_size: 2)).should be_false }
    end

    context "when given origin has the same width, height, and origin values" do
      it { (grid == Grid.new(0, 0, origin: position, max_size: 2)).should be_false }
    end
    context "when given origin has the same width, height, origin and max size values" do
      it { (grid == Grid.new(0, 0, origin: position, max_size: 4)).should be_true }
    end
  end
end
