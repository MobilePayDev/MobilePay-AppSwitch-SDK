#import "Product.h"

@implementation Product

- (id)initWithName:(NSString *)name price:(NSDecimalNumber *)price image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _name = name;
        _price = price;
        _image = image;
    }
    return self;
}

@end
