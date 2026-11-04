## [Unreleased]

### Breaking changes

- Resources backed by the v1 Partner API moved from `Bls::Core` to the new
  `Bls::Partner` namespace: `Order`, `OrderItem`, `Menu`, `MenuItem`,
  `Recipient`, `InventoryLevel`, their serializers, and the base class (`Bls::Partner::Object`).
- `Bls::Core::V1` was renamed to `Bls::Partner::Api` and `Bls::Core::V2`
  to `Bls::Core::Api` (each with its own `Authenticator`).
- `Bls::Core::Api#base_url` now includes the `/api` path prefix.
- `require "bls/core"` no longer loads `Bls::Partner`. Use
  `require "bls/partner"` for the Partner API.
- `OrderNotCreatedError` and `OrderNotCancelledError` moved to `Bls::Partner`.
- Shared plumbing moved to `Bls`: `Bls::ApiClient`, `Bls::Authorization::*`,
  `Bls::ApiOperations::Retrieve`, `Bls::ApiError`,
  `Bls::ResourceRetrievalError` and `Bls::AuthenticationError`.
- `Bls::Core::ObjectV2` was renamed to `Bls::Core::Object`. It no longer
  inherits from the v1 base class (now `Bls::Partner::Object`).
- `client_id`/`client_secret` moved from `Bls::Core.configure` to
  `Bls::Partner.configure`. `Bls::Core.configure` takes `username`,
  `password` and `environment`.
- `Bls::Partner::Api` takes and exposes `client_id` and `client_secret`
  instead of `username` and `password`.
- Test fakes split into `Bls::Core::Testing::Fake` and
  `Bls::Partner::Testing::Fake`. `bls/core/rspec` stubs `Bls::Core` and the
  new `bls/partner/rspec` stubs `Bls::Partner`.
- `Bls::Core::VERSION` was replaced by `Bls::VERSION`, defined in
  `lib/bls/version.rb`.

### Added

- `Bls::Core::Fulfillment`, a CORE API (`Bls::Core::Object`) resource for
  creating, retrieving, listing and cancelling fulfillments. `create!` sends an
  `X-Idempotency-Key` header and `retrieve_all` requires `page:`. Its
  attributes match the V2 create payload, including `zip`; validation options
  are passed as `skip_temperature_check:` and `skip_address_validation:`.
- `Bls::Core::Shipment` to hold shipments returned with a fulfillment.
- `Bls::Core::FulfillmentNotCreatedError` and
  `Bls::Core::FulfillmentNotCancelledError`.
- `Bls::ApiClient` can send query params on GET and headers on POST.

### Changed

- `activesupport` is now a declared runtime dependency, and `require "bls"`
  loads the `blank?`/`present?` core extensions the gem relies on.
- API error messages fall back to the full error response body when it has
  no `details`, which is also available as `details`.

## [0.1.0] - 2023-03-12

- Initial release
