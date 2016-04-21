//
//  UserInviteReceiveViewController.m
//  Mixl
//
//  Created by Jose on 4/19/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserInviteReceiveViewController.h"

@interface UserInviteReceiveViewController ()

@end

@implementation UserInviteReceiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _wantedUserInfo = [appController.peoplesNearby objectAtIndex:3];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView{
    
    _lblWantedUserName.text = [NSString stringWithFormat:@"%@ wants to Mixl", [_wantedUserInfo objectForKey:@"fname"]];
    NSString *image = [_wantedUserInfo objectForKey:@"image1"];
    [_imgWantedUser setImage:[UIImage imageNamed:image]];
    
}

- (IBAction)acceptClicked:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatViewController* chatViewController =
    (ChatViewController*) [storyboard instantiateViewControllerWithIdentifier:@"UserChatVC"];
    [self.navigationController pushViewController:chatViewController animated:YES];

}

- (IBAction)declineClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
