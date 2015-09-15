require 'markovian'
require "markovian/lambda/version"
require "markovian/lambda/tweeter"

module Markovian
  module Lambda
    def self.root
      Gem::Specification.find_by_name("markovian-lambda").gem_dir
    end
  end
end
