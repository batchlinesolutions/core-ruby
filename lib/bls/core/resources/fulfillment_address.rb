# frozen_string_literal: true

module Bls
  module Core
    class FulfillmentAddress < Core::Object
      def initialize(args = {})
        super
      end

      def self.build_from_response(data)
        return if data.nil?

        build(data)
      end
    end
  end
end
