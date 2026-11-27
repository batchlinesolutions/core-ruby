# frozen_string_literal: true

module Bls
  module Core
    class Address < Core::Object
      def self.build_from_response(data)
        return if data.nil?

        build(data)
      end
    end
  end
end
