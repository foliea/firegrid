require "../spec_helper"

describe Config do
  valid_body = %(
    [colors]
    border = "#000000"
    font = "#ffffff"

    [keys]
    exit = "Escape"
    squares = ["a", "b", "c", "d"]
  )

  filename = "firegrid.toml"

  describe "#validate!" do
    context "with valid body" do
      it "doesn't raise any exception" do
        Config.new(valid_body, filename).validate!
      end
    end

    context "when border color is not a valid hexadecimal color" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("#000000", "000000"), filename).validate!
        end
      end
    end

    context "when font color is not a valid hexadecimal color" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("#ffffff", "#fffff-"), filename).validate!
        end
      end
    end

    context "when there is duplicate keys" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("Escape", "a"), filename).validate!
        end
      end

    end

    context "when square keys count is below the minimum grid size" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub(%(["a", "b", "c", "d"]), "[]"), filename).validate!
        end
      end
    end

  end

  describe "#border_color" do
    it "returns border color value from given body" do
      Config.new(valid_body, filename).border_color.should eq("#000000")
    end
  end

  describe "#font_color" do
    it "returns font color value from given body" do
      Config.new(valid_body, filename).font_color.should eq("#ffffff")
    end
  end

  describe "#max_grid_size" do
    it "equals square keys count from given body" do
      Config.new(valid_body, filename).max_grid_size.should eq(4_u32)
    end
  end
end
