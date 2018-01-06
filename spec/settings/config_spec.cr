require "../spec_helper"

describe Config do
  square_keys = %(["a", "b", "c", "d", "e", "f", "g", "h"])

  valid_body = %(
    [colors]
    border = "#000000"
    font = "#ffffff"

    [keys]
    exit = "Escape"
    squares = #{square_keys}
  )

  describe "#validate!" do
    context "with valid body" do
      it "doesn't raise any exception" do
        Config.new(valid_body).validate!
      end
    end

    context "when body is not toml compliant" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new("azerty").validate!
        end
      end
    end

    context "when border color is missing" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("border = \"#000000\"", "")).validate!
        end
      end
    end

    context "when border color is not a string" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("\"#000000\"", "0")).validate!
        end
      end
    end

    context "when border color is not a valid hexadecimal color" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("#000000", "000000")).validate!
        end
      end
    end

    context "when font color is missing" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("font = \"#ffffff\"", "")).validate!
        end
      end
    end

    context "when font color is not a string" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("\"#ffffff\"", "0")).validate!
        end
      end
    end

    context "when font color is not a valid hexadecimal color" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("#ffffff", "#fffff-")).validate!
        end
      end
    end

    context "when exit key is missing" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("exit = \"Escape\"", "")).validate!
        end
      end
    end

    context "when exit key is not a string" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("\"Escape\"", "0")).validate!
        end
      end
    end

    context "when square keys are missing" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("squares = #{square_keys}", "")).validate!
        end
      end
    end

    context "when there is duplicate keys" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub("Escape", "a")).validate!
        end
      end
    end

    context "when square keys count is below the minimum grid size" do
      it "raise an error" do
        expect_raises(InvalidConfiguration) do
          Config.new(valid_body.gsub(square_keys, "[]")).validate!
        end
      end
    end
  end

  describe "#colors" do
    it "returns colors from given body" do
      Config.new(valid_body).colors.should eq({
        "border" => "#000000",
        "font"   => "#ffffff",
      })
    end
  end

  describe "#max_grid_size" do
    it "equals square keys count from given body" do
      Config.new(valid_body).max_grid_size.should eq(8_u32)
    end
  end
end
