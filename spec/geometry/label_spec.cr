require "../spec_helper"

describe Label do
  square = Square.new(50, 50, origin: Position.new(100, 120))

  describe "#size" do
    it "returns the calculated size depending on given square" do
      Label.new(square, "a").size.should eq(25)
    end
  end

  describe "#origin" do
    it "returns the calculated origin depending on given square" do
      Label.new(square, "a").origin.should eq(Position.new(113, 157))
    end

    context "when content size is above one character" do
      it "translate its origin to the left depending on given content size" do
        Label.new(square, "ab").origin.should eq(Position.new(101, 157))
      end
    end
  end
end
