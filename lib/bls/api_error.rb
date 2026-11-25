# frozen_string_literal: true

module Bls
  class ApiError < StandardError
    attr_reader :status, :title, :details

    def initialize(status:, title:, details: nil)
      @status = status
      @title = title
      @details = details
      super
    end

    def message
      if details.blank?
        "#{status} - #{title}"
      else
        "#{status} #{title} - #{description}"
      end
    end

    def self.build(response)
      data = response.data
      status = data.fetch(:status, data[:type])
      title = data.fetch(:title, data[:message])
      details = data[:details] || data[:validation_errors]
      new(status: status, title: title, details: details)
    end

    protected

    def description
      if details.is_a?(Array)
        validation_errors_description
      else
        details[:description]
      end
    end

    def validation_errors_description
      details.map { |error| "#{error[:field]} #{error[:error]}" }.join(", ")
    end
  end
end
