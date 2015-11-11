require 'spec_helper'

module Markovian
  module Publishers
    RSpec.describe Tweeter do
      let(:chain) { double(Markovian::Chain) }
      let(:tweeter) { Tweeter.new(chain) }
      let(:word) { Faker::Lorem.word }
      let(:twitter_client) { double(Twitter::Client) }

      before :each do
        allow_any_instance_of(Tweeter::Config).to receive(:twitter_client).and_return(twitter_client)
      end

      describe "#markovian_text" do
        let(:result) { double("result") }
        it "constructs a text with a random word by default" do
          allow(chain).to receive(:random_word).and_return(word)
          expect_any_instance_of(Markovian::TextBuilder).to receive(:construct).with(word, length: 140) do |instance|
            expect(instance.chain).to eq(chain)
            result
          end
          expect(tweeter.markovian_text).to eq(result)
        end

        it "will accept other words" do
          new_word = "foobar"
          expect_any_instance_of(Markovian::TextBuilder).to receive(:construct).with(new_word, length: 140) do |instance|
            expect(instance.chain).to eq(chain)
            result
          end
          expect(tweeter.markovian_text(new_word)).to eq(result)
        end
      end

      describe "#answer" do
        let(:id) { rand }

        it "responds to a given tweet" do
          expect(twitter_client).to receive(:update).with(anything, in_reply_to_status_id: id)
          tweeter.answer(id, "wor")
        end

        it "defaults to the constructed text if none provided" do
          text = double("text")
          # it's not great to stub a method on the object being tested, but so it goes
          allow(tweeter).to receive(:markovian_text).and_return(text)


          expect(twitter_client).to receive(:update).with(text, anything)
          tweeter.answer(id)
        end

        it "accepts another text to tweet" do
          word = Faker::Lorem.word
          expect(twitter_client).to receive(:update).with(word, anything)
          tweeter.answer(id, word)
        end
      end
    end
  end
end
