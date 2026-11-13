# frozen_string_literal: true

module Bls
  module Core
    class Api < Bls::Api
      def base_url
        "https://core.batchlinesolutions.#{tld}/api"
      end

      def self.build(config: Bls::Core)
        new(environment: config.environment,
            username: config.username,
            password: config.password)
      end
    end
  end
end
