# frozen_string_literal: true

RSpec.describe IntelligentFoods::Address do
  describe "#verify!" do
    it "verifys the address" do
      address = IntelligentFoods::Address.new(address1: "123 Main Street",
                                              city: "San Francisco",
                                              state: "CA",
                                              zip: "12345")
      body = build_address_response
      response = build_response(body: body)
      stub_api_response response: response

      result = address.verify!

      expect(result).to be_valid
    end

    it "uses the api v2" do
      address = IntelligentFoods::Address.new(address1: "123 Main Street",
                                              city: "San Francisco",
                                              state: "CA",
                                              zip: "12345")
      allow(IntelligentFoods).to receive(:base_url).and_call_original
      stub_api_response

      address.verify!

      expect(IntelligentFoods).to have_received(:base_url).
        with(api_version: IntelligentFoods::API_VERSION_V2)
    end

    context "when the address is invalid" do
      it "returns a falsey value" do
        address = IntelligentFoods::Address.new(address1: "123 Main Street",
                                                city: "San Francisco",
                                                state: "CA",
                                                zip: "12345")
        body = build_address_response(valid: false)
        response = build_response(body: body)
        stub_api_response response: response

        result = address.verify!

        expect(result).not_to be_valid
      end
    end
  end
end
