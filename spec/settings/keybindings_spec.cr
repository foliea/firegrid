require "../spec_helper"

describe "Keybindings" do
  keybindings = Keybindings.new({
    "exit" => "Escape", "squares" => ["a", ";"],
  })

  describe "#exit_key?" do
    it { keybindings.exit_key?("\e").should be_true }

    context "when keycode doesn't match the exit keycode" do
      it { keybindings.exit_key?("e").should be_false }
    end
  end

  describe "#square_key?" do
    it { keybindings.square_key?(";").should be_true }

    context "when keycode doesn't match any grid square key" do
      it { keybindings.square_key?("alt").should be_false }
    end
  end

  describe "#square_id" do
    it "returns square id matching given keycode" do
      keybindings.square_id("a").should eq(0)
    end

    context "when keycode doesn't match any grid square key" do
      it "raises an error" do
        expect_raises(NoMatchingKey) { keybindings.square_id("alt") }
      end
    end
  end

  describe "#square_key" do
    it "returns square key matching given id" do
      keybindings.square_key(0).should eq("a")
    end

    context "when keycode doesn't match any grid square key" do
      it "raises an error" do
        expect_raises(NoMatchingKey) { keybindings.square_key(1024) }
      end
    end
  end
end