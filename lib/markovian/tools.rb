require 'markovian'
require "markovian/tools/version"
require "markovian/importers/tweeter/csv_importer"
require "markovian/publishers/tweeter"

module Markovian
  module Tools
    def self.root
      Gem::Specification.find_by_name("markovian-tools").gem_dir
    end
  end
end
