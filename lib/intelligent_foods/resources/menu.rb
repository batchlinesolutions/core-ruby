# frozen_string_literal: true

module IntelligentFoods
  class Menu < IntelligentFoods::Object
    def initialize(args = {})
      super
    end

    def object_name
      "menu"
    end

    def resources_path
      "#{api.base_url}/menus"
    end

    def self.build_from_response(data)
      menu = build(data)
      menu.items = MenuItem.build(data[:items])
      menu
    end
  end
end
