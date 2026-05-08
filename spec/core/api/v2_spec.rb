# frozen_string_literal: true

<<<<<<< HEAD:spec/core/api/v2_spec.rb
RSpec.describe Bls::Core::V2 do
  describe "#base_url" do
    context "when the environment is production" do
      it "returns the correct url" do
        api = Bls::Core::V2.new(environment: "production")
=======
RSpec.describe IntelligentFoods::V2 do
  describe "#base_url" do
    context "when the environment is production" do
      it "returns the correct url" do
        api = IntelligentFoods::V2.new(environment: "production")
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb

        result = api.base_url

        expect(result).to eq("https://core.batchlinesolutions.com")
      end
    end

    context "when the environment is not production" do
      it "returns the correct url" do
<<<<<<< HEAD:spec/core/api/v2_spec.rb
        api = Bls::Core::V2.new(environment: "staging")
=======
        api = IntelligentFoods::V2.new(environment: "staging")
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb

        result = api.base_url

        expect(result).to eq("https://core.batchlinesolutions.dev")
      end
    end
  end

  describe "#client" do
    it "returns a api client" do
<<<<<<< HEAD:spec/core/api/v2_spec.rb
      api = Bls::Core::V2.new
=======
      api = IntelligentFoods::V2.new
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb
      build_stubbed_authenticator(api)

      result = api.client

      expect(result).to respond_to(:post)
    end
  end

  describe "#authenticate" do
    it "builds a authenticator" do
<<<<<<< HEAD:spec/core/api/v2_spec.rb
      api = Bls::Core::V2.new
=======
      api = IntelligentFoods::V2.new
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb
      build_stubbed_authenticator(api)

      api.authenticate!

<<<<<<< HEAD:spec/core/api/v2_spec.rb
      expect(Bls::Core::V2::Authenticator).to have_received(:build).once
    end

    it "authenticates" do
      api = Bls::Core::V2.new
=======
      expect(IntelligentFoods::V2::Authenticator).to have_received(:build).once
    end

    it "authenticates" do
      api = IntelligentFoods::V2.new
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb
      authenticator = build_stubbed_authenticator(api)

      api.authenticate!

      expect(authenticator).to have_received(:save!).once
    end

    context "when the authentication is present" do
      it "is authenticated" do
<<<<<<< HEAD:spec/core/api/v2_spec.rb
        api = Bls::Core::V2.new
=======
        api = IntelligentFoods::V2.new
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb
        build_stubbed_authenticator(api)

        api.authenticate!

        expect(api).to be_authenticated
      end
    end
  end

  describe "reset authentication" do
    it "removes the present authentication" do
<<<<<<< HEAD:spec/core/api/v2_spec.rb
      auth = Bls::Core::Authorization::Basic.new(token: "1234")
      api = Bls::Core::V2.new(authentication: auth)
=======
      auth = IntelligentFoods::Authorization::Basic.new(token: "1234")
      api = IntelligentFoods::V2.new(authentication: auth)
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb

      result = api.reset_authentication

      expect(result.authentication).to be_blank
    end

    it "is not authenticated" do
<<<<<<< HEAD:spec/core/api/v2_spec.rb
      auth = Bls::Core::Authorization::Basic.new(token: "1234")
      api = Bls::Core::V2.new(authentication: auth)
=======
      auth = IntelligentFoods::Authorization::Basic.new(token: "1234")
      api = IntelligentFoods::V2.new(authentication: auth)
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb

      result = api.reset_authentication

      expect(result).not_to be_authenticated
    end
  end

  describe ".build" do
    it "sets the environment" do
      config = build_config(environment: "preview")

<<<<<<< HEAD:spec/core/api/v2_spec.rb
      result = Bls::Core::V2.build(config: config)
=======
      result = IntelligentFoods::V2.build(config: config)
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb

      expect(result.environment).to eq("preview")
    end

    it "sets the username" do
      config = build_config(username: "secretUsername")

<<<<<<< HEAD:spec/core/api/v2_spec.rb
      result = Bls::Core::V2.build(config: config)
=======
      result = IntelligentFoods::V2.build(config: config)
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb

      expect(result.username).to eq("secretUsername")
    end

    it "sets the password" do
      config = build_config(password: "secretPassword")

<<<<<<< HEAD:spec/core/api/v2_spec.rb
      result = Bls::Core::V2.build(config: config)
=======
      result = IntelligentFoods::V2.build(config: config)
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb

      expect(result.password).to eq("secretPassword")
    end
  end

  def build_config(environment: "staging", username: "string",
                   password: "string")
    OpenStruct.new(environment: environment, username: username,
                   password: password)
  end

  def build_stubbed_authenticator(api)
<<<<<<< HEAD:spec/core/api/v2_spec.rb
    authenticator = Bls::Core::V2::Authenticator.build(api)
    authentication = authenticator.authentication
    client = Bls::Core::ApiClient.new(authentication: authentication)
    allow(Bls::Core::V2::Authenticator).to receive(:build).
=======
    authenticator = IntelligentFoods::V2::Authenticator.build(api)
    authentication = authenticator.authentication
    client = IntelligentFoods::ApiClient.new(authentication: authentication)
    allow(IntelligentFoods::V2::Authenticator).to receive(:build).
>>>>>>> c99e65f (Introduce Product Resource):spec/intelligent_foods/api/v2_spec.rb
      and_return(authenticator)
    allow(authenticator).to receive(:save!).and_return(client)
    authenticator
  end
end
