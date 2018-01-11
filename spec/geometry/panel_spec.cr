require "../spec_helper"

describe Panel do
  it "has a full size grid" do
    panel = Panel.new(1920_u32, 1080_u32, max_grid_size: 40_u32)

    panel.grid.should eq(Grid.new(1920_u32, 1080_u32, max_size: 40_u32))
  end

  context "when selecting a square" do
    it "returns an unclickable status" do
      panel = Panel.new(1920_u32, 1080_u32, max_grid_size: 40_u32)

      status, _ = panel.select(0)

      status.should eq(:unclickable)
    end

    it "creates a new grid from selected square" do
      panel = Panel.new(1920_u32, 1080_u32, max_grid_size: 40_u32)

      panel.select(0)

      panel.grid.should eq(Grid.new(240_u32, 216_u32, max_size: 40_u32))
    end
  end

  context "when selecting two squares consecutively" do
    it "returns an unclickable status" do
      panel = Panel.new(1920_u32, 1080_u32, max_grid_size: 40_u32)

      panel.select(0)

      status, _ = panel.select(0)

      status.should eq(:unclickable)
    end

    it "creates a new minimized grid from selected square" do
      panel = Panel.new(1920_u32, 1080_u32, max_grid_size: 40_u32)

      2.times { panel.select(0) }

      panel.grid.should eq(Grid.new(40_u32, 36_u32, max_size: 4_u32))
    end
  end

  context "when selecting three squares consecutively" do
    it "returns a clickable position" do
      panel = Panel.new(1920_u32, 1080_u32, max_grid_size: 40_u32)

      2.times { panel.select(0) }

      panel.select(0).should eq({:clickable, Position.new(10_u32, 9_u32)})
    end
  end
end
