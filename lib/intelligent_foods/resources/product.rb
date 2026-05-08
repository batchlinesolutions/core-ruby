# frozen_string_literal: true

module IntelligentFoods
  class Product < IntelligentFoods::CoreObject
    def initialize(args = {})
      super
    end

    def object_name
      "products"
    end

    def self.build_from_response(data)
      product = build(data)
      product.ingredients = Ingredient.build_from_array(data[:ingredients])
      product.nutrition_facts = NutritionFact.
                                build_from_array(data[:nutrition_facts])
      product.nutrition_facts_cooked = NutritionFact.
                                       build_from_array(
                                         data.fetch(:nutrition_facts_cooked, [])
                                       )
      product.allergens = Allergen.build_from_array(data[:allergens])
      product.dietary_tags = DietaryTag.build_from_array(data[:dietary_tags])
      product
    end
  end
end
