require "../spec_helper"

describe "Label" do
  describe "==" do
    label = Label.new(Position.new(0_u32, 0_u32), size: 2_u32)

    it { (label == Label.new(Position.new(0_u32, 1_u32), size: 3_u32)).should be_false }

    context "when given label has the same origin value" do
      it { (label == Label.new(Position.new(0_u32, 0_u32), size: 3_u32)).should be_false }
    end

    context "when given label has the same size value" do
      it { (label == Label.new(Position.new(0_u32, 1_u32), size: 2_u32)).should be_false }
    end

    context "when given label has the same origin and size values" do
      it { (label == Label.new(Position.new(0_u32, 0_u32), size: 2_u32)).should be_true }
    end
  end
end
