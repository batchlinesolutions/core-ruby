# frozen_string_literal: true

RSpec.describe IntelligentFoods do
  it "has a version number" do
    expect(IntelligentFoods::VERSION).not_to be_nil
  end

  describe "#configure" do
    it "sets the client ID" do
      IntelligentFoods.configure do |config|
        config.client_id = "abc"
      end

      expect(IntelligentFoods.client_id).to eq("abc")
    end

    it "sets the client secret" do
      IntelligentFoods.configure do |config|
        config.client_secret = "abc"
      end

      expect(IntelligentFoods.client_secret).to eq("abc")
    end

    it "sets the environment" do
      IntelligentFoods.configure do |config|
        config.environment = "preview"
      end

      expect(IntelligentFoods.environment).to eq("preview")
    end
  end
end
