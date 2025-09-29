# frozen_string_literal: true

require "base64"
require "json"
require "net/http"
require "ostruct"

require "intelligent_foods/api_client"
require "intelligent_foods/api_adapter_factory"
require "intelligent_foods/api/v1"
require "intelligent_foods/api/v2"
require "intelligent_foods/authorization"
require "intelligent_foods/authorization/basic"
require "intelligent_foods/resources/api_error"
require "intelligent_foods/authorization/bearer"
require "intelligent_foods/resources/object"
require "intelligent_foods/resources/address"
require "intelligent_foods/resources/order"
require "intelligent_foods/resources/order_item"
require "intelligent_foods/serializers/order_item_serializer"
require "intelligent_foods/resources/menu"
require "intelligent_foods/resources/menu_item"
require "intelligent_foods/serializers/menu_item_serializer"
require "intelligent_foods/resources/recipient"
require "intelligent_foods/serializers/recipient_serializer"
require "intelligent_foods/version"
require "intelligent_foods/errors"

module IntelligentFoods
  class Error < StandardError; end

  class << self
    attr_accessor :client_id, :client_secret, :environment

    def configure
      yield self
      refresh_client
      configure_environment
    end

    def client
      @client ||=
        IntelligentFoods::ApiClient.new(id: client_id, secret: client_secret)
    end

    def refresh_client
      @client = nil
    end
  end
end
