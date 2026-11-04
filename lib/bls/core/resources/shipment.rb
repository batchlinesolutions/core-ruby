# frozen_string_literal: true

module Bls
  module Core
    class Shipment < Core::Object
      def initialize(args = {})
        super
      end

      def self.build_from_response(data)
        shipment = build(data)
        shipment[:id] = data[:shipment_id]
        shipment[:items] = Array(data[:items]).map do |item|
          FulfillmentItem.build(item)
        end
        shipment
      end
    end
  end
end
