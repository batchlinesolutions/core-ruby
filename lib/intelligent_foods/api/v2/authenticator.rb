# frozen_string_literal: true

module IntelligentFoods
  class V2::Authenticator
    attr_accessor :base_url, :authentication

    def initialize(base_url:, authentication:)
      @base_url = base_url
      @authentication = authentication
    end

    def save!
      path = "#{base_url}/auth/info"
      client = IntelligentFoods::ApiClient.new(authentication: authentication)
      response = client.get(path: path)
      handle_authentication_response!(response: response)
    end

    def self.build(api)
      authentication = Authorization::Basic.
                       factory(client_id: api.username,
                               client_secret: api.password)
      new(base_url: api.base_url, authentication: authentication)
    end

    protected

    def handle_authentication_response!(response:)
      if response.success?
        authentication
      else
        handle_errors!
      end
    end

    def response_has_errors?(response)
      response.has_key?(:error)
    end

    def handle_errors!
      raise AuthenticationError.new(status: 401, title: "Authentication Failed")
    end
  end
end
