# frozen_string_literal: true

module Bls
  module Core
    class V1::Authenticator
      attr_accessor :base_url, :client_id, :client_secret

      def initialize(base_url:, client_id:, client_secret:)
        @base_url = base_url
        @client_id = client_id
        @client_secret = client_secret
      end

      def save!
        path = "#{base_url}/token"
        body = { client_id: client_id, client_secret: client_secret }
        auth = Authorization::Basic.
               factory(username: client_id, password: client_secret)
        client = Core::ApiClient.new(authentication: auth)
        response = client.post(path: path, body: body)
        handle_authentication_response!(response: response.data)
      end

      def self.build(api)
        new(base_url: api.base_url,
            client_id: api.username,
            client_secret: api.password)
      end

      protected

      def handle_authentication_response!(response:)
        if response_has_errors?(response)
          handle_errors!
        else
          handle_successful_authentication_response(response)
        end
      end

      def response_has_errors?(response)
        response.has_key?(:error)
      end

      def handle_successful_authentication_response(response)
        access_token = response[:access_token]
        Core::Authorization::Bearer.new(token: access_token)
      end

      def handle_errors!
        raise AuthenticationError.new(status: 401, title: "Authentication Failed")
      end
    end
  end
end
