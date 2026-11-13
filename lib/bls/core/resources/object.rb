# frozen_string_literal: true

module Bls
  module Core
    class Object < Bls::Resource
      def api
        @api ||= Bls::Core::Api.build
      end
    end
  end
end
