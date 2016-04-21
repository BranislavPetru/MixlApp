//
//  AcceptedOfferViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "AcceptedOfferViewController.h"

@interface AcceptedOfferViewController ()

@end

@implementation AcceptedOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView{
    
    if([_offeredUser objectForKey:@"venueImage"] == nil){
        [_imgVenue setImage:[UIImage imageNamed:@"bar"]];
    }
    else{
        //[_imgVenue setImage:[UIImage imageNamed:@"bar"]];
    }
    
    if([_offeredUser objectForKey:@"image"] == nil){
        [_imgAcceptedUser setImage:[UIImage imageNamed:@"inviteduser"]];
    }
    else{
        [_imgAcceptedUser setImage:[UIImage imageNamed:[_offeredUser objectForKey:@"image"]]];
    }
    _lblTitle.text = [NSString stringWithFormat:@"%@ accept your offer", [_offeredUser objectForKey:@"fname"]];
    
}
- (IBAction)viewVoucherClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OffersViewController* offersViewController =
    (OffersViewController*) [storyboard instantiateViewControllerWithIdentifier:@"BusicessOffersVC"];
    [self.navigationController pushViewController:offersViewController animated:YES];
}

@end
