require 'spec_helper'

module Markovian
  RSpec.describe Tools do
    describe ".root" do
      it "returns the root directory" do
        expect(Tools.root).to eq(File.expand_path(File.join(File.dirname(__FILE__), "../..")))
      end
    end
  end
end

