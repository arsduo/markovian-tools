require 'spec_helper'

module Markovian
  module Tools
    RSpec.describe TwitterConfig do
      describe "#twitter_client", :auth_data do
        let(:config) { TwitterConfig.new }

        it "returns a Twitter::REST::Client with the right config" do
          client = config.twitter_client
          client_config = client.credentials
          expect(client_config[:consumer_key]).to eq("api_key")
          expect(client_config[:consumer_secret]).to eq("api_secret")
          expect(client_config[:token]).to eq("access_token")
          expect(client_config[:token_secret]).to eq("access_token_secret")
        end
      end
    end
  end
end
