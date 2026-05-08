# frozen_string_literal: true

module Bls
  module Core
    class V2::Authenticator
      attr_accessor :authentication

      def initialize(authentication:)
        @authentication = authentication
      end

      def save!
        authentication
      end

      def self.build(api)
        authentication = Authorization::Basic.
                         factory(username: api.username,
                                 password: api.password)
        new(authentication: authentication)
      end
    end
  end
end
