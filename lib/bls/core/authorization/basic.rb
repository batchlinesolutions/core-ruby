# frozen_string_literal: true

module Bls
  module Core
    module Authorization
      class Basic < Base
        def header
          "Basic #{token}"
        end

        def self.factory(client_id:, client_secret:)
          encoded_token = Base64.strict_encode64("#{client_id}:#{client_secret}")
          new(token: encoded_token)
        end
      end
    end
  end
end
