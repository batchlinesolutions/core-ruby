# frozen_string_literal: true

RSpec.describe Bls::Partner do
  describe "#configure" do
    it "sets the client ID" do
      Bls::Partner.configure do |config|
        config.client_id = "abc"
      end

      expect(Bls::Partner.client_id).to eq("abc")
    end

    it "sets the client secret" do
      Bls::Partner.configure do |config|
        config.client_secret = "abc"
      end

      expect(Bls::Partner.client_secret).to eq("abc")
    end

    it "sets the environment" do
      Bls::Partner.configure do |config|
        config.environment = "preview"
      end

      expect(Bls::Partner.environment).to eq("preview")
    end
  end
end
