# frozen_string_literal: true

module Bls
  module Core
    module Testing
      class Fake
        def self.configure(*); end

        class Allergen
          def self.create(code: "MILK", source: "ANCHOVY")
            OpenStruct.new(code: code, source: source)
          end
        end

        class DietaryTag
          def self.create(tag: "PESCATARIAN")
            OpenStruct.new(tag: tag)
          end
        end

        class Ingredient
          def self.create(code: "MILK", name: "ANCHOVY", quantity: 1,
                          unit: "serving")
            OpenStruct.new(code: code, name: name, quantity: quantity,
                           unit: unit)
          end
        end

        class NutritionFact
          def self.create(code: "CALORIES", amount: 0, unit: "serving")
            OpenStruct.new(code: code, amount: amount, unit: unit)
          end
        end

        class FulfillmentAddress
          def self.new(name: nil, company: nil, street1: nil, street2: nil,
                       city: nil, state: nil, zip: nil, zip4: nil,
                       country: nil, email: nil, phone: nil,
                       delivery_notes: nil)
            OpenStruct.new(name: name, company: company, street1: street1,
                           street2: street2, city: city, state: state,
                           zip: zip, zip4: zip4, country: country,
                           email: email, phone: phone,
                           delivery_notes: delivery_notes)
          end
        end

        class Shipment
          def self.create(id: SecureRandom.uuid, carrier: "FEDEX",
                          tracking_code: SecureRandom.uuid,
                          tracking_url: "https://domain.com/track/1234",
                          delivery_status: "PRE_TRANSIT",
                          estimated_delivery_date: Date.today.to_s,
                          items: [Fake::FulfillmentItem.new(code: "MP0001",
                                                            quantity: 1)])
            OpenStruct.new(id: id, shipment_id: id, carrier: carrier,
                           tracking_code: tracking_code,
                           tracking_url: tracking_url,
                           delivery_status: delivery_status,
                           estimated_delivery_date: estimated_delivery_date,
                           items: items)
          end
        end

        class FulfillmentItem
          def self.new(code:, quantity:, reference_item_id: nil,
                       packaging_group: nil)
            OpenStruct.new(code: code, quantity: quantity,
                           reference_item_id: reference_item_id,
                           packaging_group: packaging_group)
          end
        end

        class Fulfillment < OpenStruct
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
                          address: Fake::FulfillmentAddress.new(zip: "12345"),
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

        class Product
          def self.new(code:, name:, status: "DRAFT", nutrition_facts: [])
            OpenStruct.new(code: code, name: name, status: status,
                           nutrition_facts: nutrition_facts,
                           allergens: [Fake::Allergen.create],
                           dietary_tags: [Fake::DietaryTag.create])
          end
        end

        def self.client
          Fake::Client.new
        end

        class ApiClient
          def self.new(*)
            Fake::Client.new
          end
        end

        class ApiClientSerializer
          def self.serialize(*)
            OpenStruct.new(id: nil, secret: nil).to_h
          end
        end

        class Client
          def initialize(*)
            self
          end

          def authenticated?
            false
          end

          def authenticate!; end
        end
      end
    end
  end
end
