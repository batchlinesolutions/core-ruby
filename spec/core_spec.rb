# frozen_string_literal: true

RSpec.describe Bls::Core do
  it "has a version number" do
    expect(Bls::Core::VERSION).not_to be_nil
  end

  describe "#configure" do
    it "sets the username" do
      Bls::Core.configure do |config|
        config.username = "abc"
      end

      expect(Bls::Core.username).to eq("abc")
    end

    it "sets the password" do
      Bls::Core.configure do |config|
        config.password = "abc"
      end

      expect(Bls::Core.password).to eq("abc")
    end

    it "sets the environment" do
      Bls::Core.configure do |config|
        config.environment = "preview"
      end

      expect(Bls::Core.environment).to eq("preview")
    end
  end
end
