//
//  UserReceiveOffersViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserReceiveOffersViewController.h"
#import "UserAcceptedVenueViewController.h"

@interface UserReceiveOffersViewController ()

@end

@implementation UserReceiveOffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _offerVenueInfo = [appController.peoplesNearby objectAtIndex:3];
    [self initView];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) initView{
    
    //NSString *venueName = [_offerVenueInfo objectForKey:@"fname"];
    NSString *venueName = @"Lounge Bar";
    _lblOfferName.text = venueName;
    //NSString *image = [_offerVenueInfo objectForKey:@"image"];
    NSString *image = @"bar";
    [_imgVenue setImage:[UIImage imageNamed:image]];
    //NSString *offerName = [_offerVenueInfo objectForKey:@"offerName"];
    NSString *offerName = @"First drink Free";
    _lblOfferName.text = [NSString stringWithFormat:@"Your Offer: %@!", offerName];
}


- (IBAction)acceptClicked:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserAcceptedVenueViewController* userAcceptedVenueViewController =
    (UserAcceptedVenueViewController*) [storyboard instantiateViewControllerWithIdentifier:@"UserAcceptedVenueVC"];
    [self.navigationController pushViewController:userAcceptedVenueViewController animated:YES];
}

- (IBAction)declineClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
