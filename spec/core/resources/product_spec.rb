# frozen_string_literal: true

RSpec.describe IntelligentFoods::Product do
  describe ".retrieve" do
    it "returns the product" do
      product_id = "MP0527"
      body = build_product_response(product_id: product_id)
      response = build_response(body: body)
      stub_api_v2_authentication
      stub_api_response response: response

      result = IntelligentFoods::Product.retrieve(product_id)

      expect(result.code).to eq(product_id)
    end
  end
end
