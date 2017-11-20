require "./spec_helper"
require "../src/config"

describe "Config" do
  describe "#square_key?" do
    it { Config.new.square_key?("semicolon").should be_true }

    context "when keycode doesn't match any grid square key" do
      it { Config.new.square_key?("alt").should be_false }
    end
  end

  describe "#square_id" do
    it "square id matching given keycode" do
      Config.new.square_id("a").should eq(0)
    end

    context "when keycode doesn't match any grid square key" do
      it "raises an exception" do
        expect_raises(NoMatchingKey) { Config.new.square_id("alt") }
      end
    end
  end
end
