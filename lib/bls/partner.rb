# frozen_string_literal: true

require "bls"
require "bls/partner/errors"
require "bls/partner/api"
require "bls/partner/api/authenticator"
require "bls/partner/resources/object"
require "bls/partner/resources/inventory_level"
require "bls/partner/resources/order"
require "bls/partner/resources/order_item"
require "bls/partner/serializers/order_item_serializer"
require "bls/partner/resources/menu"
require "bls/partner/resources/menu_item"
require "bls/partner/serializers/menu_item_serializer"
require "bls/partner/resources/recipient"
require "bls/partner/serializers/recipient_serializer"

module Bls
  module Partner
    class << self
      attr_accessor :client_id, :client_secret, :environment

      def configure
        yield self
      end
    end
  end
end
