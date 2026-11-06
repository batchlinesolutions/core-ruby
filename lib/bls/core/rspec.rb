require "rspec/rails"
require "bls/core/testing/fake"
require "bls/partner/testing/fake"
require "bls/partner/testing/fake/callback"

RSpec.configure do |config|
  config.before(:each) do
    stub_const("Bls::Core", Bls::Core::Testing::Fake)
    stub_const("Bls::Partner", Bls::Partner::Testing::Fake)
  end
end
