# AppSwitch SDK

This repository contains AppSwitch SDK source code.

# Changelog
All notable changes to this project will be documented here.

## [2.2.0] - 2019-07-18
### Added
- Added `orderId` to `MobilePayPaymentErrorBlock`. Changed parameter of `MobilePayPaymentErrorBlock` from `NSError` to `MobilePayErrorPayment` which stores `error` and  `orderId`.
- Units tests

### Changed
- Replaced `float` price type with `NSDecimalNumber`. To avoid rounding errors, an `NSDecimalNumber` - passed as price - should be initialized with either `double` or `string` value.
- Previously if SDK client passed in an amount with 3 or more digits after the comma it would be rounded up or down depending on the third digit (e.g. 12.345 -> 12.35). Now SDK is always rounding DOWN (e.g. 12.345 -> 12.34)
- Renamed error code `MobilePayErrorCodePaymentRejectedFraud` to `MobilePayErrorCodePaymentRejected`.


### Removed
- Request parameters `returnSeconds`, `productName`, `productImage`, `receiptMessage` were removed.
- Removed the ability to initialize MobilePay for Norway as it is not supported.
- Removed `productPrice` property from `MobilePaySuccessfulPayment`.
- Removed deprecated and unused code.