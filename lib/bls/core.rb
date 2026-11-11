# frozen_string_literal: true

require "bls"
require "bls/core/api"
require "bls/core/api/authenticator"
require "bls/core/resources/object"
require "bls/core/resources/allergen"
require "bls/core/resources/dietary_tag"
require "bls/core/resources/ingredient"
require "bls/core/resources/nutrition_fact"
require "bls/core/resources/product"
require "bls/core/resources/product_factory"
require "bls/core/version"

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
