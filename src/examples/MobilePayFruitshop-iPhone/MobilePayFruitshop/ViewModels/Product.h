#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSDecimalNumber *price;
@property (nonatomic, strong) UIImage *image;

- (id)initWithName:(NSString *)name price:(NSDecimalNumber *)price image:(UIImage *)image;

@end
