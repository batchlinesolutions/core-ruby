# frozen_string_literal: true

module Bls
  module Core
    module Authorization
      class Basic < Base
        def header
          "Basic #{token}"
        end

        def self.factory(username:, password:)
          encoded_token = Base64.strict_encode64("#{username}:#{password}")
          new(token: encoded_token)
        end
      end
    end
  end
end
