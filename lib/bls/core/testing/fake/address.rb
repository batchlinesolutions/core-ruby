# frozen_string_literal: true

module Bls
  module Core
    module Testing
      class Fake::Address
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
    end
  end
end
