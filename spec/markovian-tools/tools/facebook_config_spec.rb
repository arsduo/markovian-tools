require 'spec_helper'

module Markovian
  module Tools
    RSpec.describe FacebookConfig do
      describe "#facebook_client" do
        let(:config) { FacebookConfig.new }

        before :each do
          # Use the data in the fixtures directory, not the real Twitter auth
          root = Tools.root
          allow(Tools).to receive(:root).and_return(
            File.join(root, "spec/fixtures/")
          )
        end

        it "returns a Koala::Facebook::API with the right config" do
          client = config.facebook_client
          expect(client.access_token).to eq("foobark")
        end
      end
    end
  end
end
