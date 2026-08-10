# frozen_string_literal: true

RSpec.describe Bls::Core::V2 do
  describe "#base_url" do
    context "when the environment is production" do
      it "returns the correct url" do
        api = Bls::Core::V2.new(environment: "production")

        result = api.base_url

        expect(result).to eq("https://core.batchlinesolutions.com")
      end
    end

    context "when the environment is not production" do
      it "returns the correct url" do
        api = Bls::Core::V2.new(environment: "staging")

        result = api.base_url

        expect(result).to eq("https://core.batchlinesolutions.dev")
      end
    end
  end

  describe "#client" do
    it "returns a api client" do
      api = Bls::Core::V2.new
      build_stubbed_authenticator(api)

      result = api.client

      expect(result).to respond_to(:post)
    end
  end

  describe "#authenticate" do
    it "builds a authenticator" do
      api = Bls::Core::V2.new
      build_stubbed_authenticator(api)

      api.authenticate!

      expect(Bls::Core::V2::Authenticator).to have_received(:build).once
    end

    it "authenticates" do
      api = Bls::Core::V2.new
      authenticator = build_stubbed_authenticator(api)

      api.authenticate!

      expect(authenticator).to have_received(:save!).once
    end

    context "when the authentication is present" do
      it "is authenticated" do
        api = Bls::Core::V2.new
        build_stubbed_authenticator(api)

        api.authenticate!

        expect(api).to be_authenticated
      end
    end
  end

  describe "reset authentication" do
    it "removes the present authentication" do
      auth = IntelligentFoods::Authorization::Basic.new(token: "1234")
      api = IntelligentFoods::V2.new(authentication: auth)

      result = api.reset_authentication

      expect(result.authentication).to be_blank
    end

    it "is not authenticated" do
      auth = IntelligentFoods::Authorization::Basic.new(token: "1234")
      api = IntelligentFoods::V2.new(authentication: auth)

      result = api.reset_authentication

      expect(result).not_to be_authenticated
    end
  end

  describe ".build" do
    it "sets the environment" do
      config = build_config(environment: "preview")

      result = IntelligentFoods::V2.build(config: config)

      expect(result.environment).to eq("preview")
    end

    it "sets the username" do
      config = build_config(username: "secretUsername")

      result = IntelligentFoods::V2.build(config: config)

      expect(result.username).to eq("secretUsername")
    end

    it "sets the password" do
      config = build_config(password: "secretPassword")

      result = IntelligentFoods::V2.build(config: config)

      expect(result.password).to eq("secretPassword")
    end
  end

  def build_config(environment: "staging", username: "string",
                   password: "string")
    OpenStruct.new(environment: environment, username: username,
                   password: password)
  end

  def build_stubbed_authenticator(api)
    authenticator = IntelligentFoods::V2::Authenticator.build(api)
    authentication = authenticator.authentication
    client = IntelligentFoods::ApiClient.new(authentication: authentication)
    allow(IntelligentFoods::V2::Authenticator).to receive(:build).
      and_return(authenticator)
    allow(authenticator).to receive(:save!).and_return(client)
    authenticator
  end
end
