#import <Foundation/Foundation.h>

@interface MobilePayErrorPayment : NSObject

@property (nonatomic, strong, readonly) NSString *orderId;
@property (nonatomic, strong, readonly) NSError *error;

- (instancetype)initWithOrderId:(NSString *)orderId error:(NSError *)error;

@end
