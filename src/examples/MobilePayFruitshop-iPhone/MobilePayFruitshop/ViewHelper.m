//
//  ViewHelper.m
//  MobilePayFruitShop
//
//  Created by Troels Richter on 3/26/14.
//  Copyright (c) 2014 Thomas Fekete Christensen. All rights reserved.
//

#import "ViewHelper.h"
#import <UIKit/UIKit.h>

@implementation ViewHelper

+(void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
