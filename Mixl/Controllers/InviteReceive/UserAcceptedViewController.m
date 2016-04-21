//
//  UserAcceptedViewController.m
//  Mixl
//
//  Created by Jose on 4/19/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserAcceptedViewController.h"

@interface UserAcceptedViewController ()

@end

@implementation UserAcceptedViewController

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
    
    NSString *acceptedName = @"Ravon";
    _lblAcceptedName.text = [NSString stringWithFormat:@"Invite accepted by %@!", acceptedName];
    NSString *userImage = @"user";
    NSString *acceptedImage = @"inviteduser";
    [_imgSender setImage:[UIImage imageNamed:userImage]];
    [_imgRecipient setImage:[UIImage imageNamed:acceptedImage]];
}

- (IBAction)sendMessageClicked:(id)sender {

}

- (IBAction)keepSearchClicked:(id)sender {
}

@end
