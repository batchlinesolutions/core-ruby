# frozen_string_literal: true

module IntelligentFoods
  class Address < IntelligentFoods::Object
    def verify!
      uri = URI("#{IntelligentFoods.base_url}/address/verify")
      request = client.build_request_with_body(uri: uri, body: request_body)
      response = client.execute_request(request: request, uri: uri)
      if response.success?
        Address::build_from_response(response.data)
      else
        raise AddressNotVerifiedError.build(response)
      end
    end

    def self.build_from_response(data)
      address = build(data)
      address[:success] = false
    end
  end
end
