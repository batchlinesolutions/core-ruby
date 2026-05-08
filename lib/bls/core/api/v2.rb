# frozen_string_literal: true

module Bls
  module Core
    class V2
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
        "https://core.batchlinesolutions.#{tld}"
      end

      def authenticate!
        return if authenticated?

        authenticator = V2::Authenticator.build(self)
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
            username: config.username,
            password: config.password)
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
