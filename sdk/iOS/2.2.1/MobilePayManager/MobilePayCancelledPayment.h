#import <Foundation/Foundation.h>

@interface MobilePayCancelledPayment : NSObject

@property (nonatomic, strong, readonly, nullable) NSString *orderId;

- (nonnull instancetype)initWithOrderId:(nullable NSString *)orderId;

@end
