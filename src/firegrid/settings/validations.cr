module Firegrid::Settings::Validations
  # Try it here: http://rubular.com/r/cPuMa8WlKA
  private HEXADECIMAL_COLOR_REGEXP = /^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$/

  private MIN_GRID_SIZE_TRESHOLD = 4_u32

  private EXPECTED_SECTIONS = %w(colors keys)

  private EXPECTED_COLORS = %w(border font)

  def validate!
    validate_sections!

    validate_colors!

    validate_keys!
  end

  private def validate_sections!
    EXPECTED_SECTIONS.each do |section|
      unless @content.has_key?(section)
        raise InvalidConfiguration.new("Missing #{section} section")
      end
    end
  end

  private def validate_colors!
    EXPECTED_COLORS.each do |color|
      value = extract_value("colors", color)

      unless value.is_a?(String) && HEXADECIMAL_COLOR_REGEXP.match(value.as(String))
        raise InvalidConfiguration.new(
          "#{color.capitalize} color must be a valid hexadecimal color"
        )
      end
    end
  end

  private def validate_keys!
    validate_exit_key!

    validate_square_keys!

    validate_duplicate_keys!(square_keys.concat([exit_key]))
  end

  private def validate_exit_key!
    value = extract_value("keys", "exit")

    unless value.is_a?(String)
      raise InvalidConfiguration.new("Please specify a valid exit key")
    end
  end

  private def validate_square_keys!
    value = extract_value("keys", "squares")

    unless value.is_a?(Array(TOML::Type)) && square_keys.size >= MIN_GRID_SIZE_TRESHOLD
      raise InvalidConfiguration.new("Please specify at least 4 square keys")
    end
  end

  private def validate_duplicate_keys!(keys)
    raise InvalidConfiguration.new("Please remove duplicate keys") if keys != keys.uniq
  end
end
