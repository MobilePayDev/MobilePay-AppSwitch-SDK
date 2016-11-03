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
 * will start the MobilePay payment flow by swithing to the MobilePay app
 * orderId: Text with a max length of 50 characters. Sent through the purchase flow and returned to your app when the payment is completed so that you are able to deliver the right product.
 * productPrice: price of the product
 * receiptMessage: Text with a max length of 66 characters. the message is shown at the bottom of the MobilePay receipt
 * An error will occur if mobile pay isn't installed
 */
-(void) beginMobilePaymentWithOrderId:(NSString *)orderId productPrice:(float)productPrice receiptMessage:(NSString *)receiptMessage error:(void (^)(NSError *error))errorBlock;

/**
  * will start the MobilePay payment flow by swithing to the MobilePay app
  * orderId: Text with a max length of 50 characters. Sent through the purchase flow and returned to your app when the payment is completed so that you are able to deliver the right product.
  * productName: obsolete
  * productPrice: price of the product
  * productImage: image of the product (only supported for a few merchants with a special agreement with MobilePay)
  * receiptMessage: Text with a max length of 66 characters. the message is shown at the bottom of the MobilePay receipt
  * An error will occur if mobile pay isn't installed
  */
-(void) beginMobilePaymentWithOrderId:(NSString *)orderId productName:(NSString *)productName productPrice:(float)productPrice productImage:(UIImage *)productImage receiptMessage:(NSString *)receiptMessage error:(void (^)(NSError *error))errorBlock;

/**
 * handleMobilePayCallbacksWithUrl should be called from AppDelegate method:
 * -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
 * success:
 * orderId: the SDK has validated that the orderId is the same as the one sent to MobilePay
 * transactionId: MobilePay transactionId that can be found in the MobilePay activity list
 * signature: this is the payment signature that the SDK validates against to ensure the payment authenticity
 * error:
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
-(void) handleMobilePayCallbacksWithUrl:(NSURL *)url success:(void (^)(NSString *orderId, NSString *transactionId, NSString *signature))successBlock error:(void (^)(NSString *orderId, int errorCode, NSString *errorMessage))errorBlock cancel:(void (^)(NSString *orderId))cancelBlock;

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
 * for internal development purpose only
 */
-(void)setCertificate:(NSString *)certificate;
/**
 * for internal development purpose only
 */
-(void)setMobilePayUrlScheme:(NSString *)mobilePayUrlScheme;

@end
