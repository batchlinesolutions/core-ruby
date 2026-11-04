# frozen_string_literal: true

module Bls
  module Core
    class Fulfillment < Core::ObjectV2
      INGESTED = "INGESTED"
      PROCESSING = "PROCESSING"
      PROCESSED = "PROCESSED"
      COMPLETED = "COMPLETED"
      CANCELLED = "CANCELLED"
      ERROR = "ERROR"
      ACCEPTED_STATUSES = [INGESTED, PROCESSING, PROCESSED, COMPLETED].freeze

      attr_reader :skip_temperature_check, :skip_address_validation
      attr_writer :idempotency_key

      def initialize(skip_temperature_check: false,
                     skip_address_validation: false, idempotency_key: nil, **)
        super
        @skip_temperature_check = skip_temperature_check
        @skip_address_validation = skip_address_validation
        @idempotency_key = idempotency_key
      end

      def self.build_from_response(data)
        fulfillment = build(data)
        fulfillment[:id] = data[:fulfillment_id]
        fulfillment[:address] =
          FulfillmentAddress.build_from_response(data[:address])
        fulfillment[:shipments] = Array(data[:shipments]).map do |shipment|
          Shipment.build_from_response(shipment)
        end
        fulfillment
      end

      def self.retrieve_all(page:, delivery_date_from: nil,
                            delivery_date_to: nil, order_id: nil, size: nil)
        resource = new
        params = {
          delivery_date_from: delivery_date_from,
          delivery_date_to: delivery_date_to,
          order_id: order_id,
          page: page,
          size: size,
        }
        response = resource.client.get(path: resource.resources_path,
                                       params: params)
        if response.success?
          content = Array(response.data[:content])
          content.map { |data| build_from_response(data) }
        else
          raise ResourceRetrievalError.build(response)
        end
      end

      def object_name
        "fulfillments"
      end

      def create!
        response = client.post(path: resources_path, body: request_body,
                               headers: request_headers)
        if response.success?
          handle_fulfillment_created(response)
        else
          handle_fulfillment_not_created(response)
        end
      end

      def cancel!
        response = client.delete(path: resource_path)
        if response.success?
          mark_as_cancelled
          self
        else
          handle_fulfillment_not_cancelled(response)
        end
      end

      def request_body
        @request_body ||= {
          order_id: order_id.to_s,
          customer_id: customer_id,
          delivery_date: delivery_date,
          zip: zip,
          carrier: carrier,
          preferred_carrier: preferred_carrier,
          treatment: treatment,
          packing_treatment: packing_treatment,
          shipment_service_level: shipment_service_level,
          packing_notes: packing_notes,
          address: address_serialized,
          validation_options: validation_options,
          items: items_serialized,
        }.compact
      end

      def request_headers
        { "X-Idempotency-Key": idempotency_key }
      end

      def idempotency_key
        @idempotency_key ||= SecureRandom.uuid
      end

      def accepted?
        ACCEPTED_STATUSES.include?(status.to_s.upcase)
      end

      def cancelled?
        status?(CANCELLED)
      end

      def valid?
        !status?(ERROR)
      end

      protected

      def handle_fulfillment_created(response)
        self[:id] = response.data[:fulfillment_id]
        self[:status] = INGESTED
        self
      end

      def status?(value)
        status.to_s.upcase == value
      end

      def handle_fulfillment_not_created(response)
        mark_as_invalid
        raise FulfillmentNotCreatedError.build(response)
      end

      def handle_fulfillment_not_cancelled(response)
        mark_as_invalid
        raise FulfillmentNotCancelledError.build(response)
      end

      def mark_as_cancelled
        self[:status] = CANCELLED
      end

      def mark_as_invalid
        self[:status] = ERROR
      end

      def items_serialized
        return if items.nil?

        items.map do |item|
          FulfillmentItemSerializer.new(item).to_json
        end
      end

      def address_serialized
        return if address.nil?

        FulfillmentAddressSerializer.new(address).to_json
      end

      def validation_options
        {
          skip_temperature_check: skip_temperature_check,
          skip_address_validation: skip_address_validation,
        }
      end
    end
  end
end
