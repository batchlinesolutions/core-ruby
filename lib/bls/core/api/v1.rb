# frozen_string_literal: true

module Bls
  module Core
    class V1
      attr_accessor :authentication
      attr_reader :environment, :username, :password

      PRODUCTION = "production"
      STAGING = "staging"

      def initialize(username: nil, password: nil, authentication: nil,
                     environment: STAGING)
        @authentication = authentication
        @environment = environment
        @username = username
        @password = password
      end

      def base_url
        "https://api.sunbasket.#{tld}/partner/v1"
      end

      def authenticate!
        return if authenticated?

        authenticator = V1::Authenticator.build(self)
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

      def self.build(config: Bls::Core)
        new(environment: config.environment,
            username: config.client_id,
            password: config.client_secret)
      end

      protected

      def build_api_client!
        authenticate!
        Bls::Core::ApiClient.build(self)
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
