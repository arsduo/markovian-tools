# Represents a Facebook post and knows how to extract data from it.
module Markovian
  module Importers
    module Facebook
      class Post
        attr_reader :data
        def initialize(data)
          @data = data
        end

        def interesting_texts
          relevant_messages.map {|m| text(m)}
        end

        protected

        # Some stories are posted into the feed by other people, and others don't have message keys
        # (for instance, tagged in life stories).
        # or other tags.
        def relevant_messages
          messages_and_comments.select {|d| present?(d) && from_author?(d)}
        end

        def messages_and_comments
          [data, comments].flatten
        end

        def present?(datum)
          datum["message"]
        end

        def from_author?(datum)
          if datum["from"]
            datum["from"]["id"] == facebook_user_id
          end
        end

        def comments
          (data["comments"] || {})["data"] || []
        end

        def text(datum)
          datum["message"]
        end

        def facebook_user_id
          @facebook_user_id ||= Tools::FacebookConfig.new.user_id.to_s
        end
      end
    end
  end
end
