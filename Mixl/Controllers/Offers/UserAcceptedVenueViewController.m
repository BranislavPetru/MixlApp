//
//  UserAcceptedVenueViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserAcceptedVenueViewController.h"

@interface UserAcceptedVenueViewController ()

@end

@implementation UserAcceptedVenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _voucherInfo = [appController.peoplesNearby objectAtIndex:3];
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) initView{
    _btnUseNow.layer.borderWidth = 3.0f;
    _btnUseNow.layer.cornerRadius = 4.0f;
    _btnUseNow.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //NSString *imageVoucher = [_voucherInfo objectForKey:@"image"];
    NSString *imageVoucher = @"voucher";
    [_imgVoucher setImage:[UIImage imageNamed:imageVoucher]];
    //NSString *imageVenue = [_voucherInfo objectForKey:@"image"];
    NSString *imageVenue = @"venue";
    [_imgVenue setImage:[UIImage imageNamed:imageVenue]];
    //NSString *voucherName = [_voucherInfo objectForKey:@"fname"];
    NSString *voucherName = @"Free coffee for three";
    _lblVoucherName.text = voucherName;
    //NSString *venueName = [_voucherInfo objectForKey:@"fname"];
    NSString *venueName = @"Lounge Bar";
    _lblVenueName.text = venueName;
    
    //NSString *price = [_voucherInfo objectForKey:@"fname"];
    NSString *price = @"FREE";
    _lblPrice.text = price;
    //NSString *time = [_voucherInfo objectForKey:@"fname"];
    NSString *time = @"00:45:15";
    _lblRemainTime.text = time;
    //NSString *code = [_voucherInfo objectForKey:@"fname"];
    NSString *code = @"2B89";
    _lblVoucherCode.text = code;
    
}


- (IBAction)useNowClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
