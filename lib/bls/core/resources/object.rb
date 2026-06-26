# frozen_string_literal: true

module Bls
  module Core
    class Object < OpenStruct
      extend Bls::Core::ApiOperations::Retrieve

      def self.build(data)
        JSON.parse(data.to_json, object_class: self)
      end

      def resources_path
        "#{api.base_url}/#{object_name.downcase}"
      end

      def resource_path
        "#{api.base_url}/#{object_name.downcase}/#{id}"
      end

      def client
        api.client
      end

      def api
        @api ||= Bls::Core::V1.build
      end
    end
  end
end
