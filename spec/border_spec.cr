require "./spec_helper"
require "../src/border"

describe "Border" do
  describe "==" do
    border = Border.new(Position.new(0_u32, 0_u32), Position.new(1_u32, 1_u32))

    it do
      other_border = Border.new(Position.new(0_u32, 1_u32), Position.new(1_u32, 1_u32))

      (border == other_border).should be_false
    end

    context "when given border has the same origin" do
      it do
        other_border = Border.new(Position.new(0_u32, 0_u32), Position.new(0_u32, 1_u32))

        (border == other_border).should be_false
      end
    end

    context "when given border has the same end" do
      it do
        other_border = Border.new(Position.new(0_u32, 1_u32), Position.new(1_u32, 1_u32))

        (border == other_border).should be_false
      end
    end

    context "when given border has the same origin and end" do
      it do
        other_border = Border.new(Position.new(0_u32, 0_u32), Position.new(1_u32, 1_u32))

        (border == other_border).should be_true
      end
    end
  end
end
