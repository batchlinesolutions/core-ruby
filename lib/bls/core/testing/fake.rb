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

        class InventoryLevel
          def self.create(sku: "SKU1", date: Date.today.to_s,
                          distribution_center_name: "WEST_COAST",
                          quantity: 100)
            OpenStruct.new(sku: sku, date: date,
                           distribution_center: distribution_center_name,
                           quantity: quantity)
          end

          def self.serialize(sku: "SKU1", date: Date.today.to_s,
                             distribution_center_name: "WEST_COAST",
                             quantity: 100)
            create(sku: sku, date: date,
                   distribution_center_name: distribution_center_name,
                   quantity: quantity).to_h
          end

          def self.retrieve_all
            [Fake::InventoryLevel.create]
          end
        end

        class MenuItem
          def self.create(id: SecureRandom.uuid, sku: "SKU1",
                          name: "FakeMenuItem")
            OpenStruct.new(id: id, sku: sku, name: name)
          end
        end

        class Menu
          def self.new(id: Date.today.to_s)
            items = [Fake::MenuItem.create]
            OpenStruct.new(id: id, deadline: Time.zone.now,
                           shipping_fee: 9.99, items: items)
          end

          def self.retrieve(id)
            items = [Fake::MenuItem.create]
            OpenStruct.new(id: id, deadline: Time.zone.now,
                           shipping_fee: 9.99, items: items)
          end
        end

        class MenuItemSerializer
          def initialize(menu_item)
            OpenStruct.new(id: menu_item.id, sku: menu_item.sku,
                           name: menu_item.name)
          end
        end

        class NutritionFact
          def self.create(code: "CALORIES", amount: 0, unit: "serving")
            OpenStruct.new(code: code, amount: amount, unit: unit)
          end
        end

        class Recipient
          def self.new(name: nil, street1: nil, street2: nil, city: nil,
                       state: nil, zip: nil, zip4: nil, email: nil, phone: nil,
                       delivery_instructions: nil)
            OpenStruct.new(name: name, street1: street1, street2: street2,
                           city: city, state: state, zip: zip, zip4: zip4,
                           email: email, phone: phone,
                           delivery_instructions: delivery_instructions)
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

        class Order
          def initialize(*)
            self
          end

          def id
            @id ||= SecureRandom.uuid
          end

          def create!
            items = [Fake::MenuItem.create]
            ship_to = Fake::Recipient.new
            OpenStruct.new(id: SecureRandom.uuid, items: items,
                           ship_to: ship_to)
          end

          def cancel!
            OpenStruct.new(id: SecureRandom.uuid,
                           status: "CANCELLED")
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
            return [] unless page.zero?

            delivery_date = Date.today.to_s
            fulfillment = create(order_id: order_id,
                                 delivery_date: delivery_date)
            size.nil? ? [fulfillment] : [fulfillment].first(size)
          end

          def self.create(id: SecureRandom.uuid, order_id: SecureRandom.uuid,
                          status: "INGESTED", delivery_date: Date.today.to_s,
                          address: Fake::FulfillmentAddress.new(zip: "12345"),
                          shipments: [Fake::Shipment.create],
                          idempotency_key: SecureRandom.uuid)
            new(id: id, fulfillment_id: id, order_id: order_id, status: status,
                delivery_date: delivery_date, address: address,
                shipments: shipments, idempotency_key: idempotency_key)
          end

          def create!
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

        class OrderItem
          def self.new(sku:, quantity:, protein_sku:)
            OpenStruct.new(sku: sku, quantity: quantity, protein_sku: protein_sku)
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

        class OrderNotCreatedError < StandardError; end

        class OrderNotCancelledError < StandardError; end

        class AuthenticationError < StandardError; end
      end
    end
  end
end
