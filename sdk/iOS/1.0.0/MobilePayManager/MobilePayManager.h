//
//  MobilePayManager.h
//
//  Created by Troels Richter on 3/20/14.
//  Copyright (c) 2014 Trifork A/S All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobilePayManager : NSObject

+ (MobilePayManager *) sharedInstance;

/**
 * merchantId: merchant id delivered from DanskeBank MobilePay through your MobilePay business agreement
 * urlscheme: urlscheme for your app setup under UrlIdentifier in your info.plist (this needs to be done to enable app switching in general)
 */
-(void) setupWithMerchantId:(NSString *)merchantId merchantUrlScheme:(NSString *)merchantUrlScheme;

/**
 * merchantId: merchant id delivered from DanskeBank MobilePay through your MobilePay business agreement
 * urlscheme: urlscheme for your app setup under UrlIdentifier in your info.plist (this needs to be done to enable app switching in general)
 * timeoutseconds: seconds that you allow the user to spend in the MobilePay app before returning to the merchant app, if exceeded when you try to swipe in Mobile Pay errorcode 8 is returned
 * returnseconds: seconds spend on the MobilePay receipt screen before returning to the merchant app
 */
-(void) setupWithMerchantId:(NSString *)merchantId merchantUrlScheme:(NSString *)merchantUrlScheme timeoutSeconds:(int)timeoutSeconds returnSeconds:(int)returnSeconds;

/**
 * will start the MobilePay payment flow by swithing to the mobile pay app
 * orderId: is never saved in MobilePay but only sent through the purchase flow so that you are able to track the purchase and deliver the right product.
 * productPrice: price of the product
 * productImage: image of the product (only supported if you have a special deal with MobilePay)
 * receiptMessage: message shown at the bottom of the MobilePay receipt
 * An error will occur if mobile pay isn't installed
 */
-(void) beginMobilePaymentWithOrderId:(NSString *)orderId productName:(NSString *)productName productPrice:(float)productPrice productImage:(UIImage *)productImage receiptMessage:(NSString *)receiptMessage error:(void (^)(NSError *error))errorBlock;

/**
 * handleMobilePayCallbacksWithUrl should be called from AppDelegate method:
 * -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
 * errorCodes:
 * 1 = Invalid parameters sent to mobile pay
 * 2 = Validate merchant request failed
 * 3 = MobilePay app is out of date and should be updated
 * 4 = Merchant is not valid
 * 5 = Hmac parameter is not valid
 * 6 = MobilePay timeout, the purchase took more than 5 minutes
 * 7 = MobilePay amount limits exceeded. Open MobilePay 'Beløbsgrænser' to see your status.
 * 8 = Timeout set in merchant app exceeded
 * 9 = Invalid signature
 */
-(void) handleMobilePayCallbacksWithUrl:(NSURL *)url success:(void (^)(NSString *orderId, NSString *transactionId))successBlock error:(void (^)(NSString *orderId, int errorCode, NSString *errorMessage))errorBlock cancel:(void (^)(NSString *orderId))cancelBlock;

/**
 * merchant id delivered from DanskeBank MobilePay through your MobilePay business agreement
 */
@property (nonatomic) NSString *merchantId;

/**
 * seconds that you allow the user to spend in the MobilePay app before returning to the merchant app, if exceeded errorcode 8 is returned
 */
@property (nonatomic) int timeoutSeconds;

/**
 * seconds spend on the MobilePay receipt screen before returning to the merchant app
 */
@property (nonatomic) int returnSeconds;

/**
 * checks if mobilepay:// url can be opened
 */
@property (nonatomic, readonly) BOOL isMobilePayInstalled;

@property (nonatomic, readonly) NSString *mobilePayAppStoreLinkDK;

/**
 * isAppSwitchInProgress = YES after calling beginMobilePaymentWithOrderId and set to NO after calling handleMobilePayCallbacksWithUrl
 */
@property (nonatomic, readonly) BOOL isAppSwitchInProgress;

/**
 * if testMode is enabled then MobilePayManager will switch to url scheme 'mobilepay-test' instead of 'mobilepay'
 * this is only possible if you has access to test builds of MobilePay
 */
@property (nonatomic) BOOL testModeEnabled;

/**
 * if signature validation is enabled then MobilePayManager will validate the result signature from MobilePay. Default is true.
 */
@property (nonatomic) BOOL signatureValidationEnabled;

@end
