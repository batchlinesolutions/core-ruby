require "rspec/rails"
require "bls/core/testing/fake"
require "bls/core/testing/fake/fulfillment"
require "bls/core/testing/fake/address"
require "bls/core/testing/fake/fulfillment_item"
require "bls/core/testing/fake/shipment"

RSpec.configure do |config|
  config.before(:each) do
    stub_const("Bls::Core", Bls::Core::Testing::Fake)
  end
end
