# frozen_string_literal: true

module Bls
  module Core
    class ApiClient
      attr_reader :api, :authentication

      def initialize(api: nil, authentication: nil)
        @api = api
        @authentication = authentication || Authorization::Blank.new
      end

      def post(path:, body:)
        uri = URI(path)
        request = build_request_with_body(uri: uri, body: body)
        execute_request(request: request, uri: request.uri)
      end

      def delete(path:, **)
        uri = URI(path)
        request = Net::HTTP::Delete.new(uri)
        execute_request(request: request, uri: request.uri)
      end

      def get(path:, **)
        uri = URI(path)
        request = Net::HTTP::Get.new(uri)
        execute_request(request: request, uri: request.uri)
      end

      def execute_request(request:, uri:)
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          request["Authorization"] = authentication.header
          response = http.request(request)
          handle_response(response: response)
        end
      end

      def self.build(api)
        new(api: api, authentication: api.authentication)
      end

      protected

      def build_request_with_body(uri:, body:)
        request = Net::HTTP::Post.new(uri)
        request.body = body.to_json
        request["content-type"] = "application/json"
        request
      end

      def handle_response(response:)
        if authentication_failed?(response.code)
          handle_authentication_error!
        else
          body = parse_response_body(response)
          OpenStruct.new(data: body, success?: request_successful?(response.code))
        end
      end

      def handle_authentication_error!
        api.reset_authentication
        raise AuthenticationError.new(status: 401,
                                      title: "Authentication Failed")
      end

      def parse_response_body(response)
        return {} if empty_response?(response.code)
        return {} if redirection?(response.code)

        JSON.parse(response.body, symbolize_names: true)
      end

      def empty_response?(response_code)
        response_code.to_i == 204
      end

      def redirection?(response_code)
        response_code.to_i.between?(300, 399)
      end

      def request_successful?(response_code)
        response_code.to_i.between?(200, 299)
      end

      def authentication_failed?(response_code)
        response_code.to_i == 401
      end
    end
  end
end
