class Firegrid::Cli
  private USAGE = %(Usage: firegrid [OPTIONS]...
  -h, --help      display this help and exit
  -v, --version   output version information and exit)

  def self.exec(*args)
    new(*args).exec
  end

  def initialize(@argv : Array(String)); end

  def exec
    puts message
  end

  private def message
    case option
    when "--version"
      Firegrid::VERSION
    when "--help"
      USAGE
    else
      unrecognized_option
    end
  end

  private def option
    @argv.first
  end

  private def unrecognized_option
    puts "firegrid: unrecognized option '#{option}'"
  end
end
