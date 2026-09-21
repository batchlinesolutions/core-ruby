module Bls
  module Core
    module Testing
      class Fake::Callback
        def self.shipment_created(order_id: SecureRandom.uuid,
                                  shipment_id: SecureRandom.uuid,
                                  delivery_date: Date.today,
                                  carrier: "DEFAULT_CARRIER",
                                  tracking_url: "https://domain.com/track/1234",
                                  tracking_code: SecureRandom.uuid)
          {
            id: shipment_id,
            order_id: order_id,
            reference_id: SecureRandom.uuid,
            event_type: "SHIPMENT_CREATED",
            shipment_id: shipment_id,
            data: {
              id: shipment_id,
              menu_id: delivery_date.to_date.beginning_of_week.to_s,
              order_id: order_id,
              reference_id: SecureRandom.uuid,
              ship_to: {
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
              },
              delivery_date: delivery_date,
              items: [
                {
                  id: "d89397e1bad49c3b855df4406e5bf0d",
                  sku: "MP0001",
                  protein_id: "cca8eedc9842ff9a80e06242fe5a68",
                  protein_sku: "MP0001",
                  quantity: 1,
                },
              ],
              status: "CREATED",
              delivery_status: "CREATED",
              carrier: carrier,
              shipment_number: 1,
              total_shipments: 1,
              tracking_code: tracking_code,
              tracking_url: tracking_url,
              delivery_status_detail: "arrived_at_destination",
              delivery_status_message: "Left on front porch",
              est_delivery_date: delivery_date.to_s,
            },
          }
        end

        def self.shipment_cancelled(order_id: SecureRandom.uuid,
                                    shipment_id: SecureRandom.uuid,
                                    delivery_date: Date.today,
                                    carrier: "DEFAULT_CARRIER",
                                    tracking_url: "https://domain.com/track/1234",
                                    tracking_code: SecureRandom.uuid)
          {
            id: shipment_id,
            order_id: order_id,
            reference_id: SecureRandom.uuid,
            event_type: "SHIPMENT_CANCELLED",
            shipment_id: shipment_id,
            data: {
              id: shipment_id,
              menu_id: delivery_date.to_date.beginning_of_week.to_s,
              order_id: order_id,
              reference_id: SecureRandom.uuid,
              ship_to: {
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
              },
              delivery_date: delivery_date,
              items: [
                {
                  id: "d89397e1bad49c3b855df4406e5bf0d",
                  sku: "MP0001",
                  protein_id: "cca8eedc9842ff9a80e06242fe5a68",
                  protein_sku: "MP0001",
                  quantity: 1,
                },
              ],
              status: "CANCELLED",
              delivery_status: "PRE_TRANSIT",
              carrier: carrier,
              shipment_number: 1,
              total_shipments: 1,
              tracking_code: tracking_code,
              tracking_url: tracking_url,
              delivery_status_detail: "STATUS_UPDATE",
              delivery_status_message: "UPDATE_INFO",
            },
          }
        end

        def self.product(event_type: "PRODUCT_UPDATED",
                         event_id: SecureRandom.uuid,
                         sku: "S336",
                         status: "PUBLISHED")
          {
            event_id: event_id,
            event_type: event_type,
            created_at: Date.current,
            payload: {
              code: sku,
              name: "test description",
              status: status,
              refrigeration_type: "REFRIGERATED",
              refrigeration_level: "STANDARD",
              unit_volume: {
                value: 2.0,
              },
              unit_slots: {
                value: 1.0,
              },
              ingredients: [
                {
                  code: "13775",
                  name: "Tomatoes - Sun Dried, Julienne, Natural",
                  quantity: 1.0,
                  unit: "G",
                },
                {
                  code: "11950",
                  name: "Pasta - Egg Fettuccine, fresh (7oz pack)",
                  quantity: 1.0,
                  unit: "CT",
                },
                {
                  code: "10906",
                  name: "Onions - Yellow - ORG.",
                  quantity: 170.116,
                  unit: "G",
                },
                {
                  code: "10176",
                  name: "Paste - Tomato",
                  quantity: 32.38,
                  unit: "G",
                },
                {
                  code: "12466",
                  name: "Cheese - Parmesan, grated",
                  quantity: 20.6955,
                  unit: "G",
                },
                {
                  code: "11803",
                  name: "Spinach - Baby (3oz pre-pack) - ORG.",
                  quantity: 1.0,
                  unit: "CT",
                },
                {
                  code: "13169",
                  name: "Butter - Garlic Parmesan (1oz)",
                  quantity: 2.0,
                  unit: "CT",
                },
                {
                  code: "13799",
                  name: "Spice - Crushed Red Chile Flakes, (1g)",
                  quantity: 1.0,
                  unit: "CT",
                },
              ],
              nutrition_facts: {
                as_packaged: [
                  {
                    code: "MONOUNSATURATED_FAT",
                    amount: 12.972,
                    unit: "g",
                  },
                  {
                    code: "POTASSIUM",
                    amount: 670.018,
                    unit: "mg",
                  },
                  {
                    code: "CHOLESTEROL",
                    amount: 93.494,
                    unit: "mg",
                  },
                  {
                    code: "TRANS_FAT",
                    amount: 0.283,
                    unit: "g",
                  },
                  {
                    code: "CARBOHYDRATES",
                    amount: 69.498,
                    unit: "g",
                  },
                  {
                    code: "IRON",
                    amount: 1.590,
                    unit: "mg",
                  },
                  {
                    code: "TOTAL_FAT",
                    amount: 32.400,
                    unit: "g",
                  },
                  {
                    code: "SODIUM",
                    amount: 557.163,
                    unit: "mg",
                  },
                  {
                    code: "CALORIES",
                    amount: 629.521,
                    unit: "kcal",
                  },
                  {
                    code: "SATURATED_FAT",
                    amount: 10.107,
                    unit: "g",
                  },
                  {
                    code: "ADDED_SUGARS",
                    amount: 0.000,
                    unit: "g",
                  },
                  {
                    code: "POLYUNSATURATED_FAT",
                    amount: 3.668,
                    unit: "g",
                  },
                  {
                    code: "FIBER",
                    amount: 5.413,
                    unit: "g",
                  },
                  {
                    code: "PROTEIN",
                    amount: 20.576,
                    unit: "g",
                  },
                  {
                    code: "VITAMIN_D",
                    amount: 0.071,
                    unit: "mcg",
                  },
                  {
                    code: "CALCIUM",
                    amount: 93.409,
                    unit: "mg",
                  },
                  {
                    code: "TOTAL_SUGARS",
                    amount: 8.076,
                    unit: "g",
                  },
                ],
              },
              allergens: [
                {
                  code: "WHEAT",
                  source: null,
                },
                {
                  code: "MILK",
                  source: null,
                },
                {
                  code: "EGGS",
                  source: null,
                },
              ],
              dietary_tags: [
                "PESCATARIAN",
                "NO_ADDED_SUGAR",
                "VEGETARIAN",
              ],
            },
          }
        end
      end
    end
  end
end
