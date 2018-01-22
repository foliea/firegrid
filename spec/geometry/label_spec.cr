require "../spec_helper"

describe Label do
  tile = Tile.new(50, 50, origin: Position.new(100, 120))

  describe "#size" do
    it "returns the calculated size depending on given tile" do
      Label.new(tile, "a").size.should eq(25)
    end
  end

  describe "#origin" do
    it "returns the calculated origin depending on given tile" do
      Label.new(tile, "a").origin.should eq(Position.new(113, 157))
    end

    context "when content size is above one character" do
      it "translate its origin to the left depending on given content size" do
        Label.new(tile, "ab").origin.should eq(Position.new(101, 157))
      end
    end
  end

  describe "==" do
    tile = Tile.new(0, 0, origin: Position.new(1, 1))

    other_tile = Tile.new(1, 0, origin: Position.new(1, 1))

    label = Label.new(tile, "a")

    it { (label == Label.new(other_tile, "b")).should be_false }

    context "when given label has the same tile" do
      it { (label == Label.new(tile, "b")).should be_false }
    end

    context "when given label has the same content" do
      it { (label == Label.new(other_tile, "a")).should be_false }
    end

    context "when given label has the same tile and content" do
      it { (label == Label.new(tile, "a")).should be_true }
    end
  end
end
