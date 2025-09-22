# frozen_string_literal: true

RSpec.describe IntelligentFoods::Menu do
  describe ".retrieve_all" do
    it "returns the menus" do
      menu_ids = ["2023-03-12"]
      response = build_response(body: menu_ids)
      stub_api_v1_authentication
      stub_api_response response: response

      result = IntelligentFoods::Menu.retrieve_all

      expect(result.map(&:id)).to eq(menu_ids)
    end
  end

  describe ".retrieve" do
    it "returns the menu" do
      menu_id = "2023-01-01"
      body = build_menu_response(menu_id: menu_id)
      response = build_response(body: body)
      stub_api_v1_authentication
      stub_api_response response: response

      result = IntelligentFoods::Menu.retrieve(menu_id)

      expect(result.id).to eq(menu_id)
    end

    it "assigns correct number of items" do
      menu_id = "2023-01-01"
      expected_items_count = 2
      menu_items = stub_menu_items(number_of_items: expected_items_count)
      body = build_menu_response(menu_id: menu_id, menu_items: menu_items)
      response = build_response(body: body)
      stub_api_v1_authentication
      stub_api_response response: response
      menu = IntelligentFoods::Menu.retrieve(menu_id)

      result = menu.items.size

      expect(result).to eq(expected_items_count)
    end

    context "the id does not match a menu" do
      it "raises a IntelligentFoods::ResourceRetrievalError error" do
        menu_id = "2023-01-01"
        response = error_response(message: "Menu not found",
                                  http_status_code: 400)
        stub_api_response response: response

        expect {
          IntelligentFoods::Menu.retrieve(menu_id)
        }.to raise_error(IntelligentFoods::ResourceRetrievalError)
      end
    end
  end
end
