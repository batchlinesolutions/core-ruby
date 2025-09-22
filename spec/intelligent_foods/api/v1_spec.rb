# frozen_string_literal: true

RSpec.describe IntelligentFoods::V1 do
  describe "#base_url" do
    context "when the environment is production" do
      it "returns the correct url" do
        api = IntelligentFoods::V1.new(environment: "production")

        result = api.base_url

        expect(result).to eq("https://api.sunbasket.com/partner/v1")
      end
    end

    context "when the environment is not production" do
      it "returns the correct url" do
        api = IntelligentFoods::V1.new(environment: "staging")

        result = api.base_url

        expect(result).to eq("https://api.sunbasket.dev/partner/v1")
      end
    end
  end

  describe "#client" do
    it "returns a api client" do
      api = IntelligentFoods::V1.new
      build_stubbed_authenticator(api)

      result = api.client

      expect(result).to respond_to(:post)
    end
  end

  describe "#authenticate" do
    it "builds a authenticator" do
      api = IntelligentFoods::V1.new
      build_stubbed_authenticator(api)

      api.authenticate!

      expect(IntelligentFoods::V1::Authenticator).to have_received(:build).once
    end

    it "authenticates" do
      api = IntelligentFoods::V1.new
      authenticator = build_stubbed_authenticator(api)

      api.authenticate!

      expect(authenticator).to have_received(:save!).once
    end

    context "when the authentication is present" do
      it "is authenticated" do
        api = IntelligentFoods::V1.new
        build_stubbed_authenticator(api)

        api.authenticate!

        expect(api).to be_authenticated
      end
    end
  end

  describe "reset authentication" do
    it "removes the present authentication" do
      auth = IntelligentFoods::Authorization::Bearer.new(token: "1234")
      api = IntelligentFoods::V1.new(authentication: auth)

      result = api.reset_authentication

      expect(result.authentication).to be_blank
    end

    it "is not authenticated" do
      auth = IntelligentFoods::Authorization::Bearer.new(token: "1234")
      api = IntelligentFoods::V1.new(authentication: auth)

      result = api.reset_authentication

      expect(result).not_to be_authenticated
    end
  end

  describe ".build" do
    it "sets the environment" do
      config = build_config(environment: "preview")

      result = IntelligentFoods::V1.build(config: config)

      expect(result.environment).to eq("preview")
    end

    it "sets the username" do
      config = build_config(client_id: "secretUsername")

      result = IntelligentFoods::V1.build(config: config)

      expect(result.username).to eq("secretUsername")
    end

    it "sets the password" do
      config = build_config(client_secret: "secretPassword")

      result = IntelligentFoods::V1.build(config: config)

      expect(result.password).to eq("secretPassword")
    end
  end

  def build_config(environment: "staging", client_id: "cid_123",
                   client_secret: "cs_123")
    OpenStruct.new(environment: environment, client_id: client_id,
                   client_secret: client_secret)
  end

  def build_stubbed_authenticator(api)
    authenticator = IntelligentFoods::V1::Authenticator.build(api)
    authentication = IntelligentFoods::Authorization::Bearer.new(token: "123")
    client = IntelligentFoods::ApiClient.new(authentication: authentication)
    allow(IntelligentFoods::V1::Authenticator).to receive(:build).
      and_return(authenticator)
    allow(authenticator).to receive(:save!).and_return(client)
    authenticator
  end
end
