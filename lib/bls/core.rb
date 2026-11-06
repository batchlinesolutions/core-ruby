# frozen_string_literal: true

require_relative "../bls"
require_relative "core/api/v2"
require_relative "core/api/v2/authenticator"
require_relative "core/resources/object"
require_relative "core/resources/allergen"
require_relative "core/resources/dietary_tag"
require_relative "core/resources/ingredient"
require_relative "core/resources/nutrition_fact"
require_relative "core/resources/product"
require_relative "core/resources/product_factory"
require_relative "core/version"
require_relative "partner"

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
