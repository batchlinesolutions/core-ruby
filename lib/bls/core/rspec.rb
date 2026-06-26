require "rspec/rails"
require "bls/core/testing/fake"
require "bls/core/testing/fake/callback"

RSpec.configure do |config|
  config.before(:each) do
    stub_const("Bls::Core", Bls::Core::Testing::Fake)
  end
end
