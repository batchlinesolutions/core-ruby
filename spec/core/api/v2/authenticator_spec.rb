# frozen_string_literal: true

RSpec.describe Bls::Core::V2::Authenticator do
  describe "#save!" do
    it "returns a authorization scheme" do
      basic = Bls::Core::Authorization::Basic.new(token: "test")
      auth = Bls::Core::V2::Authenticator.new(authentication: basic)

      result = auth.save!

      expect(result).to respond_to(:header)
    end
  end

  describe ".build" do
    it "sets the authentication" do
      api = Bls::Core::V2.new
      basic = Bls::Core::Authorization::Basic.new(token: "test")
      allow(Bls::Core::Authorization::Basic).to receive(:factory).
        and_return(basic)

      result = Bls::Core::V2::Authenticator.build(api)

      expect(result.authentication).to eq(basic)
    end
  end

  def build_config(environment: "staging", client_id: "cid_123",
                   client_secret: "cs_123")
    OpenStruct.new(environment: environment, client_id: client_id,
                   client_secret: client_secret)
  end
end
