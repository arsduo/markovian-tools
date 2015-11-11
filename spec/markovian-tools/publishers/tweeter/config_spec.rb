require 'spec_helper'

module Markovian
  module Publishers
    class Tweeter
      RSpec.describe Config do
        describe "#twitter_client" do
          let(:config) { Config.new }

          before :each do
            # Use the data in the fixtures directory, not the real Twitter auth
            root = Tools.root
            allow(Tools).to receive(:root).and_return(
              File.join(root, "spec/fixtures/")
            )
          end

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
end
