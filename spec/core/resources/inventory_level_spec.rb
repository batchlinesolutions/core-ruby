# frozen_string_literal: true

RSpec.describe Bls::Core::InventoryLevel do
  describe ".retrieve_all" do
    it "returns the product inventory levels" do
      body = build_inventory_levels_response
      response = build_response(body: body)
      stub_api_v1_authentication
      stub_api_response response: response
      product_id = "MP0527"

      result = Bls::Core::InventoryLevel.retrieve_all

      expect(result.map(&:product_code)).to match_array(product_id)
    end
  end
end
