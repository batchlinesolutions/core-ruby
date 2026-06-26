# frozen_string_literal: true

module Bls
  module Core
    module Authorization
      class Base
        attr_reader :token

        def initialize(token: nil)
          @token = token
        end
      end
    end
  end
end
