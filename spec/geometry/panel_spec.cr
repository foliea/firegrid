require "../spec_helper"

describe Panel do
  describe "#select" do
    context "when selecting a tile" do
      it "returns an unclickable status" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        status, _ = panel.select(0)

        status.should eq(:unclickable)
      end
    end

    context "when selecting two tiles consecutively" do
      it "returns an unclickable status" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        panel.select(0)

        status, _ = panel.select(0)

        status.should eq(:unclickable)
      end
    end

    context "when selecting three tiles consecutively" do
      it "returns a clickable status" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        2.times { panel.select(0) }

        status, _ = panel.select(0)

        status.should eq(:clickable)
      end
    end

    it "returns a clickable position equals to selected tile center" do
      panel = Panel.new(1920, 1080, max_grid_size: 40)

      3.times { panel.select(0) }

      _, position = panel.select(0)

      position.should eq(Position.new(10, 9))
    end
  end

  describe "#borders" do
    it "returns all panel tiles borders" do
      panel = Panel.new(1920, 1080, max_grid_size: 4)

      panel.borders.should eq([
        Border.new(Position.new(0, 0), Position.new(1920, 0)),
        Border.new(Position.new(0, 0), Position.new(0, 1080)),
        Border.new(Position.new(1920, 0), Position.new(1920, 1080)),
        Border.new(Position.new(0, 1080), Position.new(1920, 1080)),
      ])
    end

    context "when a tile is selected" do
      it "returns borders from selected tile converted to a new grid" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        previous_borders = panel.borders

        panel.select(0)

        panel.borders.size.should eq(144)
      end
    end

    context "when two tile are selected consecutively" do
      it "returns borders from selected tile converted to a new minimized grid" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        previous_borders = panel.borders

        2.times { panel.select(0) }

        panel.borders.size.should eq(16)
      end
    end
  end

  describe "#labels" do
    it "returns labels with given texts for each panel tile" do
      panel = Panel.new(1920, 1080, max_grid_size: 4)

      panel.labels(%w(a)).should eq([
        Label.new(Tile.new(1920, 1080, origin: Position.new(0, 0)), "a"),
      ])
    end

    context "when a tile is selected" do
      it "returns labels from selected tile converted to a new grid" do
        panel = Panel.new(1920, 1080, max_grid_size: 12)

        panel.select(0)

        panel.labels(%w(a b c d e f g h i j k l)).size.should eq(9)
      end
    end

    context "when two tile are selected consecutively" do
      it "returns labels from selected tile converted to a new minimized grid" do
        panel = Panel.new(1920, 1080, max_grid_size: 40)

        2.times { panel.select(0) }

        panel.labels(%w(a b c d)).size.should eq(4)
      end
    end
  end
end
