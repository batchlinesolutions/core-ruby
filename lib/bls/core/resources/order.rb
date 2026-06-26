# frozen_string_literal: true

module Bls
  module Core
    class Order < Core::Object
      ACCEPTED = "accepted"
      CANCELLED = "cancelled"
      ERROR = "error"
      IN_PROCESS = "in_process"
      INITIALIZED = "initialized"
      PROCESSED = "processed"

      attr_reader :skip_temperature_check, :skip_address_check

      def initialize(skip_temperature_check: false, skip_address_check: false, **)
        super
        @skip_temperature_check = skip_temperature_check
        @skip_address_check = skip_address_check
      end

      def self.build_from_response(data)
        order = build(data)
        order[:items] = OrderItem.build(data[:items])
        order[:ship_to] = Recipient.build(data[:ship_to])
        order
      end

      def object_name
        "order"
      end

      def create!
        response = client.post(path: resources_path, body: request_body)
        if response.success?
          Order::build_from_response(response.data)
        else
          handle_order_not_created(response)
        end
      end

      def cancel!
        response = client.delete(path: resource_path)
        if response.success?
          mark_as_cancelled
          self
        else
          handle_order_not_cancelled(response)
        end
      end

      def request_body
        @request_body ||= {
          menu_id: menu.id,
          reference_id: external_id.to_s,
          ship_to: ship_to,
          delivery_date: delivery_date,
          items: items_json,
          validation_options: validation_options,
          callback_url: callback_url,
          callback_headers: callback_headers,
        }
      end

      def cancelled?
        status.downcase == CANCELLED
      end

      def valid?
        status.downcase != ERROR
      end

      def accepted?
        status.downcase == ACCEPTED
      end

      protected

      def handle_order_not_created(response)
        mark_as_invalid
        raise OrderNotCreatedError.build(response)
      end

      def handle_order_not_cancelled(response)
        mark_as_invalid
        raise OrderNotCancelledError.build(response)
      end

      def mark_as_cancelled
        self[:status] = CANCELLED
      end

      def mark_as_invalid
        self[:status] = ERROR
      end

      def items_json
        return if items.nil?

        items.map do |item|
          OrderItemSerializer.new(item).to_json
        end
      end

      def ship_to
        RecipientSerializer.new(recipient).to_json
      end

      def validation_options
        {
          skip_temperature_check: skip_temperature_check,
          skip_address_check: skip_address_check,
        }
      end
    end
  end
end
