# frozen_string_literal: true

module Bls
  module Core
    class Page
      attr_reader :content, :total_pages, :total_elements

      def initialize(content:, total_pages:, total_elements:)
        @content = content
        @total_pages = total_pages
        @total_elements = total_elements
      end
    end
  end
end
