//
//  SecondViewController.m
//  MobilePayFruitshop
//
//  Created by Troels Richter on 18/09/14.
//  Copyright (c) 2014 DanskeBank A/S. All rights reserved.
//

#import "AboutViewController.h"
#import "MobilePayManager.h"
@interface AboutViewController ()
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.infoLabel.text = [NSString stringWithFormat:@"This is an example app showing the features of MobilePay AppSwitch SDK - version: %@",[MobilePayManager sharedInstance].sdkVersion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
