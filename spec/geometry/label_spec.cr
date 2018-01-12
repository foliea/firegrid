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

  describe "==" do
    square = Square.new(0_u32, 0_u32, origin: Position.new(1_u32, 1_u32))

    other_square = Square.new(1_u32, 0_u32, origin: Position.new(1_u32, 1_u32))

    label = Label.new(square, "a")

    it { (label == Label.new(other_square, "b")).should be_false }

    context "when given label has the same square" do
      it { (label == Label.new(square, "b")).should be_false }
    end

    context "when given label has the same content" do
      it { (label == Label.new(other_square, "a")).should be_false }
    end

    context "when given label has the same square and content" do
      it { (label == Label.new(square, "a")).should be_true }
    end
  end
end
