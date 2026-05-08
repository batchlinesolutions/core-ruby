# frozen_string_literal: true

module IntelligentFoods
  class CoreObject < IntelligentFoods::Object
    def resources_path
      "#{api.base_url}/api/#{object_name.downcase}"
    end

    def resource_path
      "#{api.base_url}/api/#{object_name.downcase}/#{id}"
    end

    def api
      @api ||= IntelligentFoods::V2.build
    end
  end
end
