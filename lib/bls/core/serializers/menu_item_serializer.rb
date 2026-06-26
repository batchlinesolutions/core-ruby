# frozen_string_literal: true

module Bls
  module Core
    class MenuItemSerializer < SimpleDelegator
      def to_json
        {
          id: id,
          sku: sku,
          name: name,
        }
      end
    end
  end
end
