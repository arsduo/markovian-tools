require 'json'
require 'markovian/importers/facebook/post'

# This class will import a file containing newline-separated Facebook posts as JSON, returning a
# set of posts suitable for importation into a Markovian chain.
module Markovian
  module Importers
    module Facebook
      class JsonImporter
        attr_reader :path, :chain
        def initialize(path, chain = Markovian::Chain.new)
          @path = path
          @chain = chain
        end

        def texts_for_markov_analysis
          json_file_data.map {|post_data| Post.new(post_data).interesting_texts}.flatten
        end

        def add_text_to_chain
          Chain::Compiler.new(chain).build_chain(texts_for_markov_analysis)
        end

        protected

        def json_file_data
          # returns an iterator object that we can roll through
          # this does not actually start reading the file
          @json_file_enumerator ||= lines.map {|line| JSON.parse(line.chomp)}
        end

        def lines
          File.readlines(path).map(&:chomp).select {|line| line.length > 0}
        end
      end
    end
  end
end