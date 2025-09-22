# frozen_string_literal: true

module IntelligentFoods
  module ApiOperations
    module Retrieve
      def retrieve(id)
        resource = new(id: id)
        api_client = resource.client
        response = api_client.get(path: resource.resource_path)
        if response.success?
          build_from_response(response.data)
        else
          raise ResourceRetrievalError.build(response)
        end
      end

      def retrieve_all
        resource = new
        api_client = resource.client
        response = api_client.get(path: resource.resources_path)
        if response.success?
          response.data.map { |id| new(id: id) }
        else
          raise ResourceRetrievalError.build(response)
        end
      end
    end
  end
end
