//
//  ProductViewModel.h
//  MobilePayFruitShop
//
//  Created by Thomas Fekete Christensen on 18/03/14.
//  Copyright (c) 2014 Thomas Fekete Christensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) float price;
@property (nonatomic, strong) UIImage *image;

- (id)initWithName:(NSString *)name price:(float)price image:(UIImage *)image;

@end
