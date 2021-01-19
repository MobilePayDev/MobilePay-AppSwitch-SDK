#ifndef MobilePaySuccessfulPayment_h
#define MobilePaySuccessfulPayment_h

@interface MobilePaySuccessfulPayment : NSObject

@property (nonatomic, strong, readonly, nullable) NSString *orderId;
@property (nonatomic, strong, readonly, nullable) NSString *transactionId;
@property (nonatomic, strong, readonly, nullable) NSString *signature;
@property (nonatomic, readonly, nonnull) NSDecimalNumber *amountWithdrawnFromCard;

- (nonnull instancetype)initWithOrderId:(nullable NSString *)orderId
                  transactionId:(nullable NSString *)transactionId
                      signature:(nullable NSString *)signature
        amountWithdrawnFromCard:(nonnull NSDecimalNumber *)amountWithdrawnFromCard;

@end

#endif /* MobilePaySuccessfulPayment_h */
