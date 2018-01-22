require "../spec_helper"

describe Panel do
  it "has a full size grid" do
    panel = Panel.new(1920, 1080, max_grid_size: 40)

    panel.grid.should eq(Grid.new(1920, 1080, max_size: 40))
  end

  describe "#select" do
    context "when selecting a tile" do
      it "returns an unclickable status" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        status, _ = panel.select(0)

        status.should eq(:unclickable)
      end

      it "creates a new grid from selected tile" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        panel.select(0)

        panel.grid.should eq(Grid.new(240, 216, max_size: 40))
      end
    end

    context "when selecting two tiles consecutively" do
      it "returns an unclickable status" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        panel.select(0)

        status, _ = panel.select(0)

        status.should eq(:unclickable)
      end

      it "creates a new minimized grid from selected tile" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        2.times { panel.select(0) }

        panel.grid.should eq(Grid.new(40, 36, max_size: 4))
      end
    end
  end

  describe "#borders" do
    it "returns panel tile borders except borders on panel extremities" do
      panel = Panel.new(1920, 1080, max_grid_size: 4)

      panel.borders.should eq([
        Border.new(Position.new(1920, 0), Position.new(1920, 1080)),
        Border.new(Position.new(0, 1080), Position.new(1920, 1080)),
      ])
    end
  end

  describe "#labels" do
    it "returns labels with given texts for each panel tile" do
      panel = Panel.new(1920, 1080, max_grid_size: 4)

      panel.labels(%w(a)).should eq([
        Label.new(Tile.new(1920, 1080, origin: Position.new(0, 0)), "a"),
      ])
    end
  end
end
