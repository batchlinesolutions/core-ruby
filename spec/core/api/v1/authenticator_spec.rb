# frozen_string_literal: true

RSpec.describe Bls::Core::V1::Authenticator do
  describe "#save!" do
    it "returns a authorization scheme" do
      auth = Bls::Core::V1::Authenticator.
             new(base_url: "http://test.com", client_id: "id123",
                 client_secret: "secret12")
      stub_authentication

      result = auth.save!

      expect(result).to respond_to(:header)
    end

    context "when authentication fails" do
      it "raises a AuthenticationError" do
        auth = Bls::Core::V1::Authenticator.
               new(base_url: "http://test.com", client_id: "id123",
                   client_secret: "secret12")
        response_body = { error: "Authentication Failed" }
        response = error_response(body: response_body)
        stub_api_response response: response

        expect {
          auth.save!
        }.to raise_error(Bls::Core::AuthenticationError)
      end
    end
  end

  describe ".build" do
    it "sets the client_id" do
      api = Bls::Core::V1.new(username: "id123")

      result = Bls::Core::V1::Authenticator.build(api)

      expect(result.client_id).to eq("id123")
    end

    it "sets the client_secret" do
      api = Bls::Core::V1.new(password: "secret123")

      result = Bls::Core::V1::Authenticator.build(api)

      expect(result.client_secret).to eq("secret123")
    end

    it "sets the base_url" do
      api = Bls::Core::V1.new

      result = Bls::Core::V1::Authenticator.build(api)

      expect(result.base_url).to eq(api.base_url)
    end
  end

  def build_config(environment: "staging", client_id: "cid_123",
                   client_secret: "cs_123")
    OpenStruct.new(environment: environment, client_id: client_id,
                   client_secret: client_secret)
  end
end
