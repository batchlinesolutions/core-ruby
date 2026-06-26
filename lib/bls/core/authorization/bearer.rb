# frozen_string_literal: true

module Bls
  module Core
    module Authorization
      class Bearer < Base
        def header
          "Bearer #{token}"
        end
      end
    end
  end
end
