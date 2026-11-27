# frozen_string_literal: true

module Bls
  module Core
    module Testing
      class Fake::FulfillmentItem
        def self.new(code:, quantity:, reference_item_id: nil,
                     packaging_group: nil)
          OpenStruct.new(code: code, quantity: quantity,
                         reference_item_id: reference_item_id,
                         packaging_group: packaging_group)
        end
      end
    end
  end
end
