# MobilePay AppSwitch SDK
The MobilePay SDK enables your app to receive payments through the MobilePay app.
![][1]

**How it works**  
1. You initiate the payment from your own app through the SDK.

1. It automatically switches to the MobilePay App where the user is asked to sign in.

1. The user confirms the payment.

1. The receipt is shown and the user can either tap "videre" or wait one second. A counter is showing the time remaining.

1. MobilePay switches back to your own app together with a MobilePay transactionId.

## Recommendations

- Check out MobilePay AppSwitch documentation on github.
- Make sure you generate unique order ID’s, otherwise calling Refund endpoint can cause trouble.
- Make sure you do polling on payment status on your backend and do not rely on getting the response from MobilePay through the SDK.
If your backend get a status ‘Reserved’ – the user has swiped and the order can be completed and payment can be captured though the MobilePay AppSwitch API.
- Use App code obfuscasion to make it more difficult to do reverse-engineering.
- Make sure you do backend validation of the reservation details from the app, e.g. the amount.
- Testing must be done in production with real money, however you can do testing in the SDK from the app by using a test merchant id to get started.

## Latest SDK Version
Latest version is 2.2.0.
See the release notes [here](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/releases)

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
 * [Supported OS versions](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Supported-OS-versions)
 * [Known errors](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Known-errors)
 * [Cross-platform](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Cross-platform)
 * [Payment types](https://github.com/MobilePayDev/MobilePay-AppSwitch-SDK/wiki/Payment-types)
