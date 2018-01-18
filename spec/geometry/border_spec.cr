require "../spec_helper"

describe Border do
  describe "==" do
    border = Border.new(Position.new(0, 0), Position.new(1, 1))

    it do
      other_border = Border.new(Position.new(0, 1), Position.new(1, 1))

      (border == other_border).should be_false
    end

    context "when given border has the same origin" do
      it do
        other_border = Border.new(Position.new(0, 0), Position.new(0, 1))

        (border == other_border).should be_false
      end
    end

    context "when given border has the same end" do
      it do
        other_border = Border.new(Position.new(0, 1), Position.new(1, 1))

        (border == other_border).should be_false
      end
    end

    context "when given border has the same origin and end" do
      it do
        other_border = Border.new(Position.new(0, 0), Position.new(1, 1))

        (border == other_border).should be_true
      end
    end
  end
end
