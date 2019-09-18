#import <Foundation/Foundation.h>

@interface MobilePaySuccessfulPayment : NSObject

@property (nonatomic, strong, readonly) NSString *orderId;
@property (nonatomic, strong, readonly) NSString *transactionId;
@property (nonatomic, strong, readonly) NSString *signature;
@property (nonatomic, readonly, nonnull) NSDecimalNumber *amountWithdrawnFromCard;

- (instancetype)initWithOrderId:(NSString *)orderId
                  transactionId:(NSString *)transactionId
                      signature:(NSString *)signature
        amountWithdrawnFromCard:(NSDecimalNumber * __nonnull)amountWithdrawnFromCard;

@end
