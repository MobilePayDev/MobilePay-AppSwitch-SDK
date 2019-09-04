#import <Foundation/Foundation.h>

@interface MobilePayCancelledPayment : NSObject

@property (nonatomic, strong, readonly) NSString *orderId;

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
