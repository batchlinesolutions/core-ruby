# frozen_string_literal: true

module Bls
  module Core
    class FulfillmentAddressSerializer < SimpleDelegator
      def to_json
        address_object = {
          name: self[:name],
          company: self[:company],
          street1: self[:street1],
          street2: self[:street2],
          city: self[:city],
          state: self[:state],
          zip: self[:zip],
          zip4: self[:zip4],
          country: self[:country],
          email: self[:email],
          phone: self[:phone],
          delivery_notes: self[:delivery_notes],
        }
        remove_blank_values(address_object)
      end

      protected

      def remove_blank_values(obj)
        obj.delete_if do |_k, v|
          v.blank?
        end
      end
    end
  end
end
