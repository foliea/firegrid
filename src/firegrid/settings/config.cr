require "./keybindings"
require "./validations"
require "./errors"

class Firegrid::Settings::Config
  include Validations

  private FILENAME = File.join(ENV["HOME"], ".config", "firegrid", "firegrid.toml")

  # Load default configuration file content at compile time, as this file won't be available
  # at run time.
  private DEFAULT_BODY = {{ system("cat", "config/firegrid.toml").stringify }}.as(String)

  def self.load : self
    new(File.read(FILENAME)).tap { |config| config.validate! }
  rescue e : InvalidConfiguration
    STDERR.puts("#{FILENAME}: #{e.message}")

    new
  rescue Errno
    new
  end

  def initialize(@body = DEFAULT_BODY); end

  def colors : Hash(Symbol, String)
    {
      :border => extract_value("colors", "border").as(String),
      :font   => extract_value("colors", "font").as(String),
    }
  end

  def max_grid_size : Int32
    square_keys.size
  end

  def keybindings : Keybindings
    @_keybindings ||= Keybindings.new({:exit => exit_key, :squares => square_keys})
  end

  private def exit_key
    extract_value("keys", "exit").as(String)
  end

  private def square_keys
    extract_value("keys", "squares").as(Array(TOML::Type)).map { |key| key.to_s }
  end

  private def content
    TOML.parse(@body)
  end

  private def extract_value(section : String, key : String)
    values = content[section].as(Hash(String, TOML::Type))

    values.has_key?(key) ? values[key] : nil
  end
end
