# frozen_string_literal: true

module Bls
  module Core
    class FulfillmentAddress < Core::Object
      def initialize(args = {})
        super
      end

      def self.build_from_response(data)
        return if data.nil?

        address = build(data)
        address[:street1] = data[:address1]
        address[:street2] = data[:address2]
        address
      end
    end
  end
end
