# frozen_string_literal: true

module IntelligentFoods
  class V2
    attr_accessor :tld

    def initialize(tld:)
      @tld = tld
    end

    def base_url
      "https://api.intelligentfoods.#{tld}"
    end
  end
end
