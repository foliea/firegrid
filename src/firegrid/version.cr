require "yaml"

module Firegrid
  VERSION = YAML.parse({{ system("cat", "shard.yml").stringify }})["version"]
end
