require 'markovian/publishers/tweeter/config'

module Markovian
  module Publishers
    # This class, given a Markovian chain object and a Twitter OAuth token, will tweet out a
    # randomly-generated tweet.
    # Note: we call this Tweeter rather than Twitter to avoid conflict with the Twitter gem.
    class Tweeter
      # We shouldn't start our tweets with @usernames. In the unlikely event we find ourselves unable to find an
      # appropriate starter word, throw an error.
      class UnableToFindAppropriateStarterWordError < StandardError; end

      attr_reader :chain
      def initialize(chain)
        @chain = chain
      end

      def markovian_text(seed = appropriate_random_word)
        text_builder.construct(seed, length: 140)
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
        50.times do
          word = chain.random_word
          return word unless word =~ /^\@/
        end
        raise UnableToFindAppropriateStarterWordError
      end

      def twitter_client
        Config.new.twitter_client
      end

      def text_builder
        TextBuilder.new(chain)
      end
    end
  end
end
