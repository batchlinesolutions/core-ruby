# frozen_string_literal: true

module Bls
  module ApiOperations
    module Retrieve
      def retrieve(id)
        resource = new(id: id)
        data = fetch!(resource, resource.resource_path)
        build_from_response(data)
      end

      def retrieve_all
        resource = new
        data = fetch!(resource, resource.resources_path)
        build_all_from_response(data)
      end

      def build_all_from_response(data)
        data.map { |id| new(id: id) }
      end

      private

      def fetch!(resource, path)
        response = resource.client.get(path: path)
        raise ResourceRetrievalError.build(response) unless response.success?

        response.data
      end
    end
  end
end
