//
//  UserInviteReceiveViewController.h
//  Mixl
//
//  Created by Jose on 4/19/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInviteReceiveViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgWantedUser;
@property (weak, nonatomic) IBOutlet UILabel *lblWantedUserName;

@property (strong, nonatomic) NSDictionary* wantedUserInfo;

@end
