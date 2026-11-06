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
