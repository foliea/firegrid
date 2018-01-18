require "../spec_helper"

describe Panel do
  it "has a full size grid" do
    panel = Panel.new(1920, 1080, max_grid_size: 40)

    panel.grid.should eq(Grid.new(1920, 1080, max_size: 40))
  end

  context "when selecting a square" do
    it "returns an unclickable status" do
      panel = Panel.new(1920, 1080, max_grid_size: 40)

      status, _ = panel.select(0)

      status.should eq(:unclickable)
    end

    it "creates a new grid from selected square" do
      panel = Panel.new(1920, 1080, max_grid_size: 40)

      panel.select(0)

      panel.grid.should eq(Grid.new(240, 216, max_size: 40))
    end
  end

  context "when selecting two squares consecutively" do
    it "returns an unclickable status" do
      panel = Panel.new(1920, 1080, max_grid_size: 40)

      panel.select(0)

      status, _ = panel.select(0)

      status.should eq(:unclickable)
    end

    it "creates a new minimized grid from selected square" do
      panel = Panel.new(1920, 1080, max_grid_size: 40)

      2.times { panel.select(0) }

      panel.grid.should eq(Grid.new(40, 36, max_size: 4))
    end
  end

  context "when selecting three squares consecutively" do
    it "returns a clickable position" do
      panel = Panel.new(1920, 1080, max_grid_size: 40)

      2.times { panel.select(0) }

      panel.select(0).should eq({:clickable, Position.new(10, 9)})
    end
  end
end
