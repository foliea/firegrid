# TODO: Load and use a configuration file
# Probably a TOML file.
class Config

  DEFAULT_TARGET_KEYS = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "semicolon",
    "quote",
    "comma",
    "period",
    "escape",
    "slash",
    "lbracket",
    "rbracket",
    "backslash",
    "tilde",
    "num1",
    "num0"
  ]

  def matches_target?(keycode)
    DEFAULT_TARGET_KEYS.includes?(keycode)
  end

  def target_id(keycode)
    DEFAULT_TARGET_KEYS.index(keycode)
  end

end
