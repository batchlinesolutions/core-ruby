# frozen_string_literal: true

RSpec.describe IntelligentFoods::Address do
  describe "#verify" do
    it "uses the api v2" do
      address = IntelligentFoods::Address.new(address1: "123 Main Street",
                                              city: "San Francisco",
                                              state: "CA",
                                              zip: "12345")
      client = IntelligentFoods.client
      allow(IntelligentFoods).to receive(:client).and_return(client)
      allow(client).to receive(:build_request_with_body).and_call_original
      expected_uri = URI("https://api.intelligentfoods.dev/address/validate")
      stub_api_response

      address.verify

      expect(client).to have_received(:build_request_with_body).
        with(hash_including(uri: expected_uri))
    end

    context "when the response is valid" do
      it "is a valid address" do
        address = IntelligentFoods::Address.new(address1: "123 Main Street",
                                                city: "San Francisco",
                                                state: "CA",
                                                zip: "12345")
        body = build_address_response
        response = build_response(body: body)
        stub_api_response response: response

        result = address.verify

        expect(result).to be_valid
      end
    end

    context "when the response is invalid" do
      it "is not a valid address" do
        address = IntelligentFoods::Address.new(address1: "123 Main Street",
                                                city: "San Francisco",
                                                state: "CA",
                                                zip: "12345")
        body = build_address_response(valid: false)
        response = build_response(body: body)
        stub_api_response response: response

        result = address.verify

        expect(result).not_to be_valid
      end
    end
  end
end
