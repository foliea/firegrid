require "../spec_helper"

describe Keybindings do
  keybindings = Keybindings.new({
    :exit => "Escape", :tiles => ["a", ";", "Backspace", "b"],
  })

  describe "#exit_keycode?" do
    it { keybindings.exit_keycode?("\e").should be_true }

    context "when keycode doesn't match the exit keycode" do
      it { keybindings.exit_keycode?("e").should be_false }
    end
  end

  describe "#tile_keycode?" do
    it { keybindings.tile_keycode?(";").should be_true }

    context "when keycode is not human readable" do
      it { keybindings.tile_keycode?("\b").should be_true }
    end

    context "when keycode doesn't match any grid tile key" do
      it { keybindings.tile_keycode?("alt").should be_false }
    end
  end

  describe "#tile_id" do
    it "returns tile id matching given keycode" do
      keybindings.tile_id("a").should eq(0)
    end

    context "when keycode is not human readable" do
      it "returns tile id matching given keycode" do
        keybindings.tile_id("\b").should eq(2)
      end
    end

    context "when keycode doesn't match any grid tile key" do
      it "raises an error" do
        expect_raises(NoMatchingKey) { keybindings.tile_id("alt") }
      end
    end
  end
end
