# frozen_string_literal: true

module IntelligentFoods
  class ResourceRetrievalError < ApiError; end

  class OrderNotCancelledError < ApiError; end

  class OrderNotCreatedError < ApiError; end

  class AuthenticationError < ApiError; end
end
