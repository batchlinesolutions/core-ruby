# frozen_string_literal: true

module Bls
  module Partner
    class Api
      attr_accessor :authentication
      attr_reader :environment, :client_id, :client_secret

      PRODUCTION = "production"
      STAGING = "staging"

      def initialize(client_id: nil, client_secret: nil, authentication: nil,
                     environment: STAGING)
        @authentication = authentication
        @environment = environment
        @client_id = client_id
        @client_secret = client_secret
      end

      def base_url
        "https://api.sunbasket.#{tld}/partner/v1"
      end

      def authenticate!
        return if authenticated?

        authenticator = Api::Authenticator.build(self)
        @authentication = authenticator.save!
      end

      def client
        build_api_client!
      end

      def authenticated?
        authentication.present?
      end

      def reset_authentication
        @authentication = nil
        self
      end

      def self.build(config: Bls::Partner)
        new(environment: config.environment,
            client_id: config.client_id,
            client_secret: config.client_secret)
      end

      protected

      def build_api_client!
        authenticate!
        Bls::ApiClient.build(self)
      end

      def tld
        @tld ||= determine_tld
      end

      def determine_tld
        if environment == PRODUCTION
          "com"
        else
          "dev"
        end
      end
    end
  end
end
