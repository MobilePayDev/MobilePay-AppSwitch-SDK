# MobilePay AppSwitch SDK
The MobilePay SDK enables your app to receive payments through the MobilePay app.
![][1]

**How it works**  
1 - You initiate the payment from your own app through the SDK.

2 - It automatically switches to the MobilePay App where the user is asked to sign in.

3 - The user confirms the payment.

4 - The receipt is shown and the user can either tap "videre" or wait one second. A counter is showing the time remaining.

5 - MobilePay switches back to your own app together with a MobilePay transactionId.

## Latest SDK Version
|Platform|Version|
|:--------|:---|
|Android| 1.8.2|
|iOS| 1.8.1|

## Support
For technical questions about the MobilePay AppSwitch SDK or other related questions, please contact us via e-mail at [developer@mobilepay.dk](mailto://developer@mobilepay.dk)

## Requirements
Please look at the MobilePay Developer Portal for further details [MobilePay Developer Portal](https://developer.mobilepay.dk/appswitch-main)

  [1]: https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/blob/master/doc/wiki/images/mobilepay_appswitch_purchase_flow.png "MobilePay AppSwitch purchase flow"

## MerchantID for test purposes
The MerchantID for testing depends on which country you are targeting. The following IDs can be used:

**APPDK0000000000** - Denmark

**APPFI0000000000** - Finland

When the test MerchantID is used you are able to complete the payment flow without transferring any money.

## Cross-platform
Please look at the wiki page for further details [wiki site](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Cross-platform)

## Documentation
 * [Getting started on iPhone](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Getting-started-on-iPhone)
 * [Getting started on Android](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Getting-started-on-Android)
 * [Error handling](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Error-handling)
 * [Parameter specification](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Parameter-specification)
 * [Security](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Security)
 * [Supported OS versions](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Supported-OS-versions)
 * [Known errors](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Known-errors)
 * [Cross-platform](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Cross-platform)
 * [Payment types](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Payment-types)
