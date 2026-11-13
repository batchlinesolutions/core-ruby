# frozen_string_literal: true

module Bls
  module Partner
    class Api < Bls::Api
      def base_url
        "https://api.sunbasket.#{tld}/partner/v1"
      end

      def self.build(config: Bls::Partner)
        new(environment: config.environment,
            username: config.client_id,
            password: config.client_secret)
      end
    end
  end
end
