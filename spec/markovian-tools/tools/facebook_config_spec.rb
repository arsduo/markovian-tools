require 'spec_helper'

module Markovian
  module Tools
    RSpec.describe FacebookConfig, :auth_data do
      let(:config) { FacebookConfig.new }

      describe "#facebook_client" do
        it "returns a Koala::Facebook::API with the right config" do
          client = config.facebook_client
          expect(client.access_token).to eq("foobark")
        end
      end

      describe "#user_id" do
        it "returns the facebook user id" do
          expect(config.user_id).to eq("facebook_user_id")
        end
      end
    end
  end
end
