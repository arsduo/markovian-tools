require 'spec_helper'

module Markovian
  module Importers
    module Facebook
      RSpec.describe ApiDataDownloader do
        let(:api) { double(Koala::Facebook::API) }
        let(:destination_path) { "/tmp/markovian-test" }
        let(:downloader) { ApiDataDownloader.new(destination_path) }

        before :each do
          allow_any_instance_of(Tools::FacebookConfig).to receive(:facebook_client).and_return(api)
        end

        describe "#read_from_api" do
          let(:page1) { Koala::Facebook::API::GraphCollection.new({"data" => [{"a" => 2}, {"b" => 3}]}, api) }
          let(:page2) { Koala::Facebook::API::GraphCollection.new({"data" => [{"c" => 4}]}, api) }
          let(:contents) { File.readlines(destination_path).map(&:chomp) }
          let(:expected) { (page1 + page2).map(&:to_json) }

          before :each do
            allow(api).to receive(:get_connection).with("me", "feed").and_return(page1)
            allow(page1).to receive(:next_page).and_return(page2)
            allow(page2).to receive(:next_page).and_return(nil)
          end

          it "writes the data to the desired file" do
            downloader.read_from_api
            expect(contents).to eq(expected)
          end

          it "overwrites the file if called again" do
            downloader.read_from_api
            new_downloader = ApiDataDownloader.new(destination_path)
            new_downloader.read_from_api
            expect(contents).to eq(expected)
          end

          it "does not log by default" do
            expect_any_instance_of(Kernel).not_to receive(:puts)
            downloader.read_from_api
          end

          it "will log if appropriate" do
            expect_any_instance_of(Kernel).to receive(:puts)
            downloader = ApiDataDownloader.new(destination_path, debug: true)
            downloader.read_from_api
          end
        end
      end
    end
  end
end
