# frozen_string_literal: true

module Bls
  module Core
    class FulfillmentItemSerializer < SimpleDelegator
      def to_json
        {
          reference_item_id: self[:reference_item_id],
          code: code,
          packaging_group: self[:packaging_group],
          quantity: quantity,
        }.compact
      end
    end
  end
end
