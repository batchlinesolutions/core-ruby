# frozen_string_literal: true

module IntelligentFoods
  module Authorization
    class Base
      attr_reader :token

      def initialize(token: nil)
        @token = token
      end
    end
  end
end
