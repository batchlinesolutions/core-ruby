# frozen_string_literal: true

module Bls
  module Partner
    class OrderItemSerializer < SimpleDelegator
      def to_json
        {
          sku: sku,
          protein_sku: protein_sku,
          quantity: quantity,
        }
      end
    end
  end
end
