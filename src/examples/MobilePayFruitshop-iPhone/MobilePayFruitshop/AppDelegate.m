#import "AppDelegate.h"
#import "ViewHelper.h"
#import "MobilePayManager.h"
#import "MobilePayCancelledPayment.h"
#import "MobilePaySuccessfulPayment.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    /*
     * INFO!!! THIS IS JUST A DEMO APP, WHICH SHOWS A VERY BASIC EXAMPLE OF HOW YOU USE THE APPSWITCH SDK
     * THIS ONLY DEMONSTRATES A 'SUN SHINE SCENARIO' - YOU HAVE TO HANDLE CANCELLATIONS OR BACKGROUND OR POOR/MISSING NETWORK SCENARIOS YOURSELF!!
     */
    
    
    /*
     * This is the constructor. All default values are set in this method, so if you want to override the defaults then do it AFTER this method is called!!
     * See the MobilePayManager.h file for the defaults of each property
     * Please don't use the fruitshop urlscheme in your production app!!
     */
    [[MobilePayManager sharedInstance] setupWithMerchantId:@"APPDK0000000000" merchantUrlScheme:@"fruitshop" country:MobilePayCountry_Denmark];
    
    /*
     * Examples of customizing different values/settings of the SDK
     * See the MobilePayManager.h file for the defaults of each property
     */
    
    // IsMobilePayInstalled
    //  This is the ONLY method that can called before the setupWithMerchantId:, and it checks if AppStore version of MobilePay is installed on the device
    //  Currently there is a version of the mobilepay app in three countries and therefore three urlschemes:
    //  Denmark: mobilepay://
    //  Finland: mobilepayfi://
    //
    //  if ([[MobilePayManager sharedInstance]isMobilePayInstalled:MobilePayCountry_Denmark]) {
    //      [[MobilePayManager sharedInstance] setupWithMerchantId:@"APPDK0000000000" merchantUrlScheme:@"fruitshop" timeoutSeconds:60 captureType:MobilePayCaptureType_PartialCapture country:MobilePayCountry_Denmark];
    //  }
    
    
    //Reserve/Capture
    //[MobilePayManager sharedInstance].captureType = MobilePayCaptureType_Reserve ;//this will make a reservation of the money, instead of a instant capture/withdrawal. Default is Capture.
    
    // TimeoutSeconds - this is just an example, but our recommendation is to set it set it high in case the user is on a edge / poor  connection
    //[[MobilePayManager sharedInstance]setTimeoutSeconds:90];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    //IMPORTANT - YOU MUST USE THIS IF YOU COMPILING YOUR AGAINST IOS9 SDK
    [self handleMobilePayPaymentWithUrl:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //IMPORTANT - THIS IS DEPRECATED IN IOS9 - USE 'application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options' INSTEAD
    [self handleMobilePayPaymentWithUrl:url];
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    //IMPORTANT - THIS IS DEPRECATED IN IOS9 - USE 'application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options' INSTEAD
    [self handleMobilePayPaymentWithUrl:url];
    return YES;
}

- (void)handleMobilePayPaymentWithUrl:(NSURL *)url
{
    [[MobilePayManager sharedInstance]
     handleMobilePayPaymentWithUrl:url
     success:^(MobilePaySuccessfulPayment * _Nullable mobilePaySuccessfulPayment) {
         NSString *orderId = mobilePaySuccessfulPayment.orderId;
         NSString *transactionId = mobilePaySuccessfulPayment.transactionId;
         NSString *amountWithdrawnFromCard = [NSString stringWithFormat:@"%f", mobilePaySuccessfulPayment.amountWithdrawnFromCard.floatValue];
         NSLog(@"MobilePay purchase succeeded: Your have now paid for order with id '%@' and MobilePay transaction id '%@' and the amount withdrawn from the card is: '%@'", orderId, transactionId,amountWithdrawnFromCard);
         [ViewHelper showAlertWithTitle:@"MobilePay Succeeded" message:[NSString stringWithFormat:@"You have now paid with MobilePay. Your MobilePay transactionId is '%@'", transactionId]];
     } error:^(MobilePayErrorPayment * _Nullable mobilePayErrorPayment) {
         NSError *error = mobilePayErrorPayment.error;
         NSDictionary *dict = error.userInfo;
         NSString *errorMessage = [dict valueForKey:NSLocalizedFailureReasonErrorKey];
         NSLog(@"MobilePay purchase failed:  Error code '%li' and message '%@'",(long)error.code,errorMessage);
         [ViewHelper showAlertWithTitle:[NSString stringWithFormat:@"MobilePay Error %li",(long)error.code] message:errorMessage];
         
         //Show an appropriate error message to the user. Check MobilePayManager.h for a complete description of the error codes
         
         //An example of using the MobilePayErrorCode enum
         //if (error.code == MobilePayErrorCodeUpdateApp) {
         //    NSLog(@"You must update your MobilePay app");
         //}
     } cancel:^(MobilePayCancelledPayment * _Nullable mobilePayCancelledPayment) {
         NSLog(@"MobilePay purchase with order id '%@' cancelled by user", mobilePayCancelledPayment.orderId);
         [ViewHelper showAlertWithTitle:@"MobilePay Canceled" message:@"You cancelled the payment flow from MobilePay, please pick a fruit and try again"];
     }];
}

@end
