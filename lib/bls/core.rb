# frozen_string_literal: true

require "securerandom"

require "bls"
require "bls/core/errors"
require "bls/core/api"
require "bls/core/api/authenticator"
require "bls/core/resources/object"
require "bls/core/resources/allergen"
require "bls/core/resources/dietary_tag"
require "bls/core/resources/ingredient"
require "bls/core/resources/nutrition_fact"
require "bls/core/resources/fulfillment"
require "bls/core/resources/fulfillment_address"
require "bls/core/resources/fulfillment_item"
require "bls/core/resources/shipment"
require "bls/core/serializers/fulfillment_item_serializer"
require "bls/core/serializers/fulfillment_address_serializer"
require "bls/core/resources/product"
require "bls/core/resources/product_factory"

module Bls
  module Core
    class Error < StandardError; end

    class << self
      attr_accessor :environment, :username, :password

      def configure
        yield self
      end
    end
  end
end
