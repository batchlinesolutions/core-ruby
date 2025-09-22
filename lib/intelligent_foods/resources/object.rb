# frozen_string_literal: true

module IntelligentFoods
  class Object < OpenStruct
    extend IntelligentFoods::ApiOperations::Retrieve

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
      @api ||= IntelligentFoods::V1.build
    end
  end
end
