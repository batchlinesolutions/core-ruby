# frozen_string_literal: true

module Bls
  module Partner
    class InventoryLevel < Partner::Object
      def object_name
        "inventory-level"
      end

      def resources_path
        "#{api.base_url}/products/inventory-levels"
      end

      def to_json
        {
          sku: sku,
          date: date,
          distribution_center: distribution_center,
          quantity: quantity
        }
      end

      def self.build_all_from_response(data)
        build_from_array(data[:inventory])
      end
    end
  end
end
