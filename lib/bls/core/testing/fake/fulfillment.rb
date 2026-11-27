# frozen_string_literal: true

module Bls
  module Core
    module Testing
      class Fake::Fulfillment < OpenStruct
        ACCEPTED_STATUSES = %w[INGESTED PROCESSING PROCESSED COMPLETED].freeze

        def self.retrieve(id)
          create(id: id)
        end

        def self.retrieve_all(page:, delivery_date_from: nil,
                              delivery_date_to: nil,
                              order_id: SecureRandom.uuid, size: nil)
          fulfillment = create(order_id: order_id,
                               delivery_date: Date.today.to_s)
          content = page.zero? ? [fulfillment].first(size || 1) : []
          OpenStruct.new(content: content, total_pages: 1,
                         total_elements: 1)
        end

        def self.create(id: SecureRandom.uuid, order_id: SecureRandom.uuid,
                        status: "INGESTED", delivery_date: Date.today.to_s,
                        address: Fake::Address.new(zip: "12345"),
                        shipments: [Fake::Shipment.create])
          new(id: id, fulfillment_id: id, order_id: order_id, status: status,
              delivery_date: delivery_date, address: address,
              shipments: shipments)
        end

        def create!(idempotency_key:)
          self[:fulfillment_id] = id
          self[:status] = "INGESTED"
          self
        end

        def cancel!
          self[:status] = "CANCELLED"
          self
        end

        def accepted?
          ACCEPTED_STATUSES.include?(status.to_s.upcase)
        end

        def cancelled?
          status.to_s.upcase == "CANCELLED"
        end

        def valid?
          status.to_s.upcase != "ERROR"
        end
      end
    end
  end
end
