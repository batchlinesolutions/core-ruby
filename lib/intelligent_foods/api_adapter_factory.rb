# frozen_string_literal: true

module IntelligentFoods
  class ApiAdapterFactory
    attr_accessor :tld, :api_version

    def initialize(tld:, api_version: nil)
      @tld = tld
      @api_version = api_version
    end

    def create
      return IntelligentFoods::V1.new(tld: tld) unless api_version.present?

      api_version.new(tld: tld)
    end

    def self.build(resource, environment: IntelligentFoods.environment)
      tld = if environment == "production"
              "com"
            else
              "dev"
            end
      new(tld: tld, api_version: resource.api_version).create
    end
  end
end
