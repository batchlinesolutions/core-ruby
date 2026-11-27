# frozen_string_literal: true

module Bls
  module Core
    module Testing
      class Fake::Shipment
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
    end
  end
end
