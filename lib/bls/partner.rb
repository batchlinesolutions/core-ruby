# frozen_string_literal: true

require_relative "../bls"
require_relative "partner/errors"
require_relative "partner/api/v1"
require_relative "partner/api/v1/authenticator"
require_relative "partner/resources/object"
require_relative "partner/resources/inventory_level"
require_relative "partner/resources/order"
require_relative "partner/resources/order_item"
require_relative "partner/serializers/order_item_serializer"
require_relative "partner/resources/menu"
require_relative "partner/resources/menu_item"
require_relative "partner/serializers/menu_item_serializer"
require_relative "partner/resources/recipient"
require_relative "partner/serializers/recipient_serializer"

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
