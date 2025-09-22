# frozen_string_literal: true

module IntelligentFoods
  class Address < IntelligentFoods::Object
    def verify!
      base_url = IntelligentFoods.base_url(api_version: "v2")
      uri = URI("#{base_url}/address/validate")
      request = client.build_request_with_body(uri: uri, body: request_body)
      response = client.execute_request(request: request, uri: uri)
      if response.success?
        Address::build(response.data)
      else
        raise AddressNotVerifiedError.build(response)
      end
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
