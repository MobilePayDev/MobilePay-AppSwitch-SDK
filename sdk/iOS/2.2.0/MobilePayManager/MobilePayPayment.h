#import <Foundation/Foundation.h>

/**
 * Contains information about the payment being processed.
 */
@interface MobilePayPayment : NSObject

// Required
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, nonnull) NSDecimalNumber *productPrice;

@property (nonatomic, strong) NSString *bulkRef;

/**
 * Initialize payment object with required values
 * orderId: Text with a max length of 50 characters. Sent through the purchase flow and returned to your app when the payment is completed so that you are able to deliver the right product.
 * productPrice: price of the product
 */
- (MobilePayPayment *)initWithOrderId:(NSString *)orderId productPrice:(NSDecimalNumber * __nonnull)productPrice;

@end
