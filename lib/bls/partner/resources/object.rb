# frozen_string_literal: true

module Bls
  module Partner
    class Object < Bls::Resource
      def api
        @api ||= Bls::Partner::Api.build
      end
    end
  end
end
