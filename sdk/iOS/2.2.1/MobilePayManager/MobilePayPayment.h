#import <Foundation/Foundation.h>

/**
 * Contains information about the payment being processed.
 */
@interface MobilePayPayment : NSObject

// Required
@property (nonatomic, strong, nonnull) NSString *orderId;
@property (nonatomic, nonnull) NSDecimalNumber *productPrice;

@property (nonatomic, strong, nullable) NSString *bulkRef;

/**
 * Initialize payment object with required values
 * orderId: Text with a max length of 50 characters. Sent through the purchase flow and returned to your app when the payment is completed so that you are able to deliver the right product.
 * productPrice: price of the product
 */
- (nonnull MobilePayPayment *)initWithOrderId:(nonnull NSString *)orderId productPrice:(nonnull NSDecimalNumber *)productPrice;

@end
