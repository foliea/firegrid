require "../spec_helper"

describe Keybindings do
  keybindings = Keybindings.new({
    :exit => "Escape", :squares => ["a", ";", "Backspace", "b"],
  })

  describe "#exit_keycode?" do
    it { keybindings.exit_keycode?("\e").should be_true }

    context "when keycode doesn't match the exit keycode" do
      it { keybindings.exit_keycode?("e").should be_false }
    end
  end

  describe "#square_keycode?" do
    it { keybindings.square_keycode?(";").should be_true }

    context "when keycode is not human readable" do
      it { keybindings.square_keycode?("\b").should be_true }
    end

    context "when keycode doesn't match any grid square key" do
      it { keybindings.square_keycode?("alt").should be_false }
    end
  end

  describe "#square_id" do
    it "returns square id matching given keycode" do
      keybindings.square_id("a").should eq(0)
    end

    context "when keycode is not human readable" do
      it "returns square id matching given keycode" do
        keybindings.square_id("\b").should eq(2)
      end
    end

    context "when keycode doesn't match any grid square key" do
      it "raises an error" do
        expect_raises(NoMatchingKey) { keybindings.square_id("alt") }
      end
    end
  end
end
