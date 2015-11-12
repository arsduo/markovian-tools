require 'markovian'
require "markovian/tools/version"
require "markovian/importers/tweeter/csv_importer"
require "markovian/publishers/tweeter"
require "markovian/tools/facebook_config"

module Markovian
  module Tools
    def self.root
      Gem::Specification.find_by_name("markovian-tools").gem_dir
    end
  end
end
