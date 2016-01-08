require 'spec_helper'

module Markovian
  module Importers
    module Facebook
      RSpec.describe JsonImporter do
        let(:facebook_csv_path) { File.join(SPEC_ROOT, "fixtures/importers/facebook", "sample.json")}
        let(:importer) { JsonImporter.new(facebook_csv_path) }

        describe "#texts_for_markov_analysis" do
          it "collects the right texts, including comments" do
            expect(importer.texts_for_markov_analysis).to eq([
              "There's a bubble tea/coffee place near me that's open (relatively) late! Major win. — at Furama in Chicago, IL",
              "Whoops, that's not Furama. Accidentally picked the wrong place.",
              "After much experimentation, I've found a stain for pine that matches the oak in the rest of the apartment! Looking forward to the carpenter coming on Monday and to finally getting the first set of back window frames finished.",
              "Stained glass windows are now a thing I'm collecting, it seems. — at Brownstone Antiques in Chicago, IL",
              "Show 21: the Neocade, a great night of strange and beautiful videogames and a gaming-themed TML. — at Neo-Futurists in Chicago, IL"
            ])
          end
        end

        describe "#add_text_to_chain" do
          context "if there is no previous chain" do
            let(:chain) { importer.add_text_to_chain }

            it "creates a chain with the relevant data", temporary_srand: 3 do
              expect(3.times.map { chain.next_word("stained") }).to eq(["glass", "glass", "glass"])
            end
          end

          context "if there is a previous chain" do
            let(:chain) { Markovian::Chain.new }
            let(:importer) { JsonImporter.new(facebook_csv_path, chain) }

            before :each do
              chain.lengthen("stained", next_word: "clothes")
            end

            it "incorporates the data into the existing chain", temporary_srand: 2 do
              importer.add_text_to_chain
              expect(3.times.map { chain.next_word("stained") }).to eq(["clothes", "glass", "glass"])
            end
          end
        end
      end
    end
  end
end
