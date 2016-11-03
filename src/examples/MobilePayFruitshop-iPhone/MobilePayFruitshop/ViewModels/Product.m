//
//  ProductViewModel.m
//  MobilePayFruitShop
//
//  Created by Thomas Fekete Christensen on 18/03/14.
//  Copyright (c) 2014 Thomas Fekete Christensen. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id)initWithName:(NSString *)name price:(float)price image:(UIImage *)image
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
