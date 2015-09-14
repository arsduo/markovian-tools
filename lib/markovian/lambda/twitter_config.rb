require 'twitter'
require 'yaml'

module Markovian
  module Lambda
    class TwitterConfig
      def twitter_client
        Twitter::REST::Client.new do |config|
          config.consumer_key        = twitter_credentials["api_key"]
          config.consumer_secret     = twitter_credentials["api_secret"]
          config.access_token        = twitter_credentials["access_token"]
          config.access_token_secret = twitter_credentials["access_token_secret"]
        end
      end

      protected

      def twitter_credentials
        @twitter_credentials ||= YAML.load_file(twitter_credential_file_path)
      end

      def twitter_credential_file_path
        File.join(Lambda.root, "data/twitter_auth.yml")
      end
    end
  end
end
