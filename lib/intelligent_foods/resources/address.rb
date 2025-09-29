# frozen_string_literal: true

module IntelligentFoods
  class Address < IntelligentFoods::Object
    def api_version
      IntelligentFoods::V2
    end

    def verify
      uri = URI("#{api.base_url}/address/validate")
      basic_auth_token = client.basic_auth_token
      request = client.build_request_with_body(uri: uri, body: request_body)
      response = client.execute_request(request: request, uri: uri,
                                        authorization: basic_auth_token)
      Address::build(response.data)
    end

    def valid?
      valid
    end

    protected

    def request_body
      @request_body ||= {
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        zip: zip,
      }
    end
  end
end
