# frozen_string_literal: true

module Bls
  module Core
    class ResourceRetrievalError < ApiError; end

    class OrderNotCancelledError < ApiError; end

    class OrderNotCreatedError < ApiError; end

    class AuthenticationError < ApiError; end
  end
end
