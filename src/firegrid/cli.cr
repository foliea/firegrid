class Firegrid::Cli
  private EXIT_FAILURE = 1

  private USAGE = %(Usage: firegrid [OPTIONS]...
  -h, --help      display this help and exit
  -v, --version   output version information and exit)

  def self.exec(*args)
    new(*args).exec
  end

  def initialize(@argv : Array(String)); end

  def exec
    case option
    when "-v", "--version"
      STDOUT.puts(VERSION)
    when "-h", "--help"
      STDOUT.puts(USAGE)
    else
      STDERR.puts("firegrid: unrecognized option '#{option}'")

      exit(EXIT_FAILURE)
    end
  end

  private def option
    @argv.first
  end
end
