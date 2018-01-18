require "../spec_helper"

describe Square do
  it "has given origin" do
    origin = Position.new(1, 1)

    Square.new(10, 10, origin: origin).origin.should eq(origin)
  end

  describe "#center" do
    it "returns square center origin" do
      square = Square.new(50, 50, origin: Position.new(100, 120))

      square.center.should eq(Position.new(125, 145))
    end
  end

  describe "#borders" do
    origin = Position.new(10, 20)

    square = Square.new(100, 50, origin: origin)

    it "returns square borders" do
      square.borders["top"].should eq(
        Border.new(
          Position.new(10, 20),
          Position.new(110, 20),
        )
      )
      square.borders["left"].should eq(
        Border.new(
          Position.new(10, 20),
          Position.new(10, 70),
        )
      )
      square.borders["right"].should eq(
        Border.new(
          Position.new(110, 20),
          Position.new(110, 70),
        )
      )
      square.borders["bottom"].should eq(
        Border.new(
          Position.new(10, 70),
          Position.new(110, 70),
        )
      )
    end
  end

  describe "#to_grid" do
    origin = Position.new(50, 40)

    square = Square.new(10, 10, origin: origin)

    it "returns a grid with same size and origin" do
      expected_grid = Grid.new(10, 10, origin: origin, max_size: 4)

      square.to_grid(expected_grid.max_size).should eq(expected_grid)
    end

    it "returns a grid with given max size" do
      square.to_grid(10).max_size.should eq(10)
    end
  end

  describe "==" do
    position = Position.new(1, 1)

    square = Square.new(0, 0, origin: position)

    it { (square == Square.new(1, 1, origin: Position.new(2, 2))).should be_false }

    context "when given square has the same width and origin values" do
      it { (square == Square.new(0, 1, origin: position)).should be_false }
    end

    context "when given square has the same height and origin values" do
      it { (square == Square.new(1, 0, origin: position)).should be_false }
    end

    context "when given origin has the same width, height, and origin values" do
      it { (square == Square.new(0, 0, origin: position)).should be_true }
    end
  end
end
