require 'markovian/lambda/twitter_config'

module Markovian
  module Lambda
    # This class, given a Markovian corpus object and a Twitter OAuth token, will tweet out a
    # randomly-generated tweet.
    class Tweeter
      # We shouldn't start our tweets with @usernames. In the unlikely event we find ourselves unable to find an
      # appropriate starter word, throw an error.
      class UnableToFindAppropriateStarterWordError < StandardError; end

      attr_reader :corpus
      def initialize(corpus)
        @corpus = corpus
      end

      def markovian_text(seed = corpus.random_word)
        text_builder.construct(seed, length: 140, start_result_with_seed: true)
      end

      def tweet!(text = markovian_text)
        twitter_client.update(text)
      end

      def answer(tweet_id, text = markovian_text)
        twitter_client.update(text, in_reply_to_status_id: tweet_id)
      end

      protected

      # Don't send messages directly at other people -- try a reasonable number of times to find a
      # starter word that _isn't_ someone's name.
      # In the future, we'll have the ability to answer people, but for now, let's be careful.
      def appropriate_random_word
        (0...50).times do
          word = corpus.random_word
          return word unless word =~ /^\@/
        end
        raise UnableToFindAppropriateStarterWordError
      end

      def twitter_client
        TwitterConfig.new.twitter_client
      end

      def text_builder
        TextBuilder.new(corpus)
      end
    end
  end
end
