# frozen_string_literal: true

module Bls
  module Core
    class Product < Bls::Core::ObjectV2
      def initialize(args = {})
        super
      end

      def object_name
        "products"
      end

      def self.build_from_response(data)
        product = build(data)
        product.ingredients = Ingredient.build_from_array(data[:ingredients])
        as_packaged = NutritionFact.
                      build_from_array(data[:nutrition_facts][:as_packaged])
        as_cooked = NutritionFact.
                    build_from_array(data[:nutrition_facts][:as_cooked])
        product.allergens = Allergen.build_from_array(data[:allergens])
        product.dietary_tags = DietaryTag.build_from_array(data[:dietary_tags])
        product.nutrition_facts = { as_packaged: as_packaged,
                                    as_cooked: as_cooked }
        product
      end
    end
  end
end
