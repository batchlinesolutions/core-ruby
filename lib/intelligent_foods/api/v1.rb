# frozen_string_literal: true

module IntelligentFoods
  class V1
    attr_accessor :tld

    def initialize(tld:)
      @tld = tld
    end

    def base_url
      "https://api.sunbasket.#{tld}/partner/v1"
    end
  end
end
