## [Unreleased]

### Added

- `Bls::Core::Fulfillment`, a CORE V2 API (`Bls::Core::ObjectV2`) resource for
  creating, retrieving, listing and cancelling fulfillments. `create!` sends an
  `X-Idempotency-Key` header and `retrieve_all` requires `page:`. Its
  attributes match the V2 create payload, including `zip`; validation options
  are passed as `skip_temperature_check:` and `skip_address_validation:`.
- `Bls::Core::Shipment` to hold shipments returned with a fulfillment.
- `Bls::Core::FulfillmentNotCreatedError` and
  `Bls::Core::FulfillmentNotCancelledError`.
- `Bls::Core::ApiClient` can send query params on GET and headers on POST.

### Changed

- API error messages fall back to the full error response body when it has
  no `details`, which is also available as `details`.

## [0.1.0] - 2023-03-12

- Initial release
