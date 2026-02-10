# frozen_string_literal: true

module IntelligentFoods
  class InventoryLevel < IntelligentFoods::Object
    def object_name
      "inventory-level"
    end

    def resources_path
      "#{api.base_url}/products/inventory-levels"
    end

    def self.retrieve_all
      resource = new
      api_client = resource.client
      response = api_client.get(path: resource.resources_path)
      if response.success?
        response.data[:products].map { |product| build(product) }
      else
        raise ResourceRetrievalError.build(response)
      end
    end
  end
end
