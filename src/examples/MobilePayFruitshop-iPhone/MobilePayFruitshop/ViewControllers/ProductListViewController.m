//
//  ProductListViewController.m
//  MobilePayFruitShop
//
//  Created by Thomas Fekete Christensen on 18/03/14.
//  Copyright (c) 2014 Thomas Fekete Christensen. All rights reserved.
//

#import "ProductListViewController.h"
#import "Product.h"
#import "MobilePayManager.h"
#import "MobilePayPayment.h"

@interface ProductListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) UIAlertView *errorInOrderAlertView;
@end

@implementation ProductListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.products = [[NSMutableArray alloc] init];
    
    [self.products addObject:[[Product alloc] initWithName:@"Orange" price:10.00 image:[UIImage imageNamed:@"orange.png"]]];
    [self.products addObject:[[Product alloc] initWithName:@"Kiwi" price:0.56 image:[UIImage imageNamed:@"kiwi.png"]]];
    [self.products addObject:[[Product alloc] initWithName:@"Jordbær" price:4.43 image:[UIImage imageNamed:@"strawberry.png"]]];
    [self.products addObject:[[Product alloc] initWithName:@"Fruit basket" price:1501.52 image:[UIImage imageNamed:@"fruit_basket.png"]]];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ItemCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    Product *product = [self.products objectAtIndex:indexPath.row];

    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f kr.", product.price];
    cell.imageView.image = product.image;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product = [self.products objectAtIndex:indexPath.row];
    
    MobilePayPayment *payment = [[MobilePayPayment alloc]initWithOrderId:@"123456" productPrice:product.price];
    
    if (payment && (payment.orderId.length > 0) && (payment.productPrice >= 0)) {
        
        [[MobilePayManager sharedInstance]beginMobilePaymentWithPayment:payment error:^(NSError * _Nonnull error) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                            message:[NSString stringWithFormat:@"reason: %@, suggestion: %@",error.localizedFailureReason, error.localizedRecoverySuggestion]
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Install MobilePay",nil];
            [alert show];
            
        }];
        
    }else{
        self.errorInOrderAlertView = [[UIAlertView alloc] initWithTitle:@"Error in your order"
                                                        message:@"One or more parameters in your order is invalid"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok",nil];
        [self.errorInOrderAlertView show];
    }
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if((buttonIndex == 1) && (![alertView isEqual:self.errorInOrderAlertView])) /* NO = 0, YES = 1 */
    {
        //This could also be the Norwegian or the Finish app you want to link to - this is just an example
        //[MobilePayManager sharedInstance].mobilePayAppStoreLinkNO
        //[MobilePayManager sharedInstance].mobilePayAppStoreLinkFI
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[MobilePayManager sharedInstance].mobilePayAppStoreLinkDK]];
    }
}


@end
