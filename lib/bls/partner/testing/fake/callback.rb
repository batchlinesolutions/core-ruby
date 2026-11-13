module Bls
  module Partner
    module Testing
      class Fake::Callback
        SHIP_TO = {
          name: "Full Name",
          company: "Company Name",
          street1: "123 Main Street",
          street2: "",
          city: "Gotham",
          state: "NY",
          zip: "12345",
          zip4: "",
          email: "example@domain.com",
          phone: "5555555555",
          delivery_instructions: "Default delivery instructions",
        }.freeze

        ITEMS = [
          {
            id: "d89397e1bad49c3b855df4406e5bf0d",
            sku: "MP0001",
            protein_id: "cca8eedc9842ff9a80e06242fe5a68",
            protein_sku: "MP0001",
            quantity: 1,
          }.freeze,
        ].freeze

        def self.shipment_created(delivery_date: Date.today, **options)
          shipment_event(event_type: "SHIPMENT_CREATED",
                         delivery_date: delivery_date,
                         status: "CREATED",
                         delivery_status: "CREATED",
                         status_details: {
                           delivery_status_detail: "arrived_at_destination",
                           delivery_status_message: "Left on front porch",
                           est_delivery_date: delivery_date.to_s,
                         },
                         **options)
        end

        def self.shipment_cancelled(**options)
          shipment_event(event_type: "SHIPMENT_CANCELLED",
                         status: "CANCELLED",
                         delivery_status: "PRE_TRANSIT",
                         status_details: {
                           delivery_status_detail: "STATUS_UPDATE",
                           delivery_status_message: "UPDATE_INFO",
                         },
                         **options)
        end

        def self.shipment_event(event_type:, status:, delivery_status:,
                                status_details:,
                                order_id: SecureRandom.uuid,
                                shipment_id: SecureRandom.uuid,
                                delivery_date: Date.today,
                                carrier: "DEFAULT_CARRIER",
                                tracking_url: "https://domain.com/track/1234",
                                tracking_code: SecureRandom.uuid)
          {
            id: shipment_id,
            order_id: order_id,
            reference_id: SecureRandom.uuid,
            event_type: event_type,
            shipment_id: shipment_id,
            data: {
              id: shipment_id,
              menu_id: delivery_date.to_date.beginning_of_week.to_s,
              order_id: order_id,
              reference_id: SecureRandom.uuid,
              ship_to: SHIP_TO.dup,
              delivery_date: delivery_date,
              items: ITEMS.map(&:dup),
              status: status,
              delivery_status: delivery_status,
              carrier: carrier,
              shipment_number: 1,
              total_shipments: 1,
              tracking_code: tracking_code,
              tracking_url: tracking_url,
              **status_details,
            },
          }
        end
        private_class_method :shipment_event
      end
    end
  end
end
