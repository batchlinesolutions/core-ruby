# frozen_string_literal: true

RSpec.describe Bls::Core::Product do
  describe ".retrieve" do
    it "returns the product" do
      product_id = "MP0527"
      body = build_product_response(product_id: product_id)
      response = build_response(body: body)
      stub_api_v2_authentication
      stub_api_response response: response

      result = Bls::Core::Product.retrieve(product_id)

      expect(result.code).to eq(product_id)
    end

    it "returns packaged and cooked nutrition facts" do
      body = build_product_response
      response = build_response(body: body)
      stub_api_v2_authentication
      stub_api_response response: response

      result = Bls::Core::Product.retrieve("TEST123")

      expect(result.nutrition_facts.keys).to match_array(
        [:as_packaged, :as_cooked]
      )
    end
  end
end
