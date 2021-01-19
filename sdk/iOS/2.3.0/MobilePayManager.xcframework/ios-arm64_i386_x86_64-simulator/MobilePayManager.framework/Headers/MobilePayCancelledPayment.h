#ifndef MobilePayCancelledPayment_h
#define MobilePayCancelledPayment_h

@interface MobilePayCancelledPayment : NSObject

@property (nonatomic, strong, readonly, nullable) NSString *orderId;

- (nonnull instancetype)initWithOrderId:(nullable NSString *)orderId;

@end

#endif /* MobilePayCancelledPayment_h */
