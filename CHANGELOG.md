## [Unreleased]

## [0.2.0] - 2026-11-06

### Breaking changes

- Resources backed by the v1 Partner API moved from `Bls::Core` to the new
  `Bls::Partner` namespace: `Order`, `OrderItem`, `Menu`, `MenuItem`,
  `Recipient`, `InventoryLevel`, their serializers, `V1` (and
  `V1::Authenticator`), and the base class (`Bls::Partner::Object`).
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
  `Bls::Partner::Testing::Fake`. `bls/core/rspec` stubs both.


## [0.1.0] - 2023-03-12

- Initial release
