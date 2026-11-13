## [Unreleased]

### Removed

- Unused `Bls::Core::Error`.
- `Bls::Core::Testing::Fake` no longer defines `.client`, `ApiClient`,
  `ApiClientSerializer` or `Client`; none of these exist on the real `Bls::Core`.

### Changed

- `Bls::Core::Api` and `Bls::Partner::Api` now share a `Bls::Api` base class.
- `Bls::Core::Object` and `Bls::Partner::Object` now share a `Bls::Resource`
  base class, so `build_from_array` is available on Partner resources too.
- `Bls::ApiOperations::Retrieve` exposes a `build_all_from_response` hook,
  used by `InventoryLevel` instead of overriding `retrieve_all`.

## [0.2.0] - 2026-11-06

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
- Test fakes split into `Bls::Core::Testing::Fake` and
  `Bls::Partner::Testing::Fake`. `bls/core/rspec` stubs `Bls::Core` and the
  new `bls/partner/rspec` stubs `Bls::Partner`.


## [0.1.0] - 2023-03-12

- Initial release
