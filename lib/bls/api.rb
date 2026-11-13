# frozen_string_literal: true

module Bls
  class Api
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

    def authenticate!
      return if authenticated?

      authenticator = self.class::Authenticator.build(self)
      @authentication = authenticator.save!
    end

    def client
      authenticate!
      Bls::ApiClient.build(self)
    end

    def authenticated?
      authentication.present?
    end

    def reset_authentication
      @authentication = nil
      self
    end

    protected

    def tld
      environment == PRODUCTION ? "com" : "dev"
    end
  end
end
