require "./firegrid/*"

if ARGV.any?
  Firegrid::Cli.exec(ARGV)
else
  Firegrid::Application.launch
end
