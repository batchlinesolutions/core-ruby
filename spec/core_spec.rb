# frozen_string_literal: true

RSpec.describe Bls::Core do
  it "has a version number" do
    expect(Bls::Core::VERSION).not_to be_nil
  end

  describe "#configure" do
    it "sets the client ID" do
      Bls::Core.configure do |config|
        config.client_id = "abc"
      end

      expect(Bls::Core.client_id).to eq("abc")
    end

    it "sets the client secret" do
      Bls::Core.configure do |config|
        config.client_secret = "abc"
      end

      expect(Bls::Core.client_secret).to eq("abc")
    end

    it "sets the environment" do
      Bls::Core.configure do |config|
        config.environment = "preview"
      end

      expect(Bls::Core.environment).to eq("preview")
    end
  end
end
