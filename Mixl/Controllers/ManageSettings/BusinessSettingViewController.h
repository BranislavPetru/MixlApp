//
//  BusinessSettingViewController.h
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@interface BusinessSettingViewController : BaseViewController <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet NMRangeSlider *standardSlider;
@property (nonatomic, strong) IBOutlet UILabel*                 lblRadius;
@property (nonatomic, strong) IBOutlet UILabel*                 lblAgeRange;
@property (nonatomic, strong) IBOutlet UISegmentedControl*      segGander;
@property (nonatomic, strong) IBOutlet UIButton*                btnSeeAllCheckbox;
@property (nonatomic, strong) IBOutlet UIButton*                btnSeeFriendsCheckbox;
@property (nonatomic, strong) IBOutlet UIButton*                btnContactAllCheckbox;
@property (nonatomic, strong) IBOutlet UIButton*                btnContactFriendsCheckbox;
@property (nonatomic, strong) IBOutlet UISwitch*                swFriendRequest;
@property (nonatomic, strong) IBOutlet UISwitch*                swInvitesUsers;

@end
