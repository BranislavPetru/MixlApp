//
//  UserMenuSideViewController.m
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserMenuSideViewController.h"
#import "MenuViewCell.h"
#import "Constants.h"
#import "SHAlertHelper.h"
#import "UserInformation.h"
#import "Utils.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "SWRevealViewController.h"

@interface UserMenuSideViewController ()

@end

@implementation UserMenuSideViewController{
    NSArray* actionArray;
    int     selectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"UserMenuSideViewController created");
    [Utils appDelegate].sideMenu = self;
    [self Initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.photoView.image){
        //NSString* avatarImageURL = [[UserInformation sharedInstance] displayPic];
        //NSLog(@"avatar image URL : %@", avatarImageURL);
        
//        if ([avatarImageURL isEqual:[NSNull null]]){
//            [self.photoView setImage:[UIImage imageNamed:@"avatar_placeholder.png"]];
//        }else{
//            [self.photoView setImageWithURL:[NSURL URLWithString:avatarImageURL] placeholderImage:nil options:SDWebImageProgressiveDownload usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        }
        UIImage* userImage = [UIImage imageNamed:@"user"];
        [_photoView setImage:userImage];
    }
    
    [super viewWillAppear:animated];
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int actionTagCounts = (int)[actionArray count];
    
    return actionTagCounts;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *actionTagItemIdentifire = @"ActionMenuItemCell";
    
    MenuViewCell* menuViewCell = (MenuViewCell*)[tableView dequeueReusableCellWithIdentifier:actionTagItemIdentifire];
    
    if (menuViewCell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuViewCell" owner:self options:nil];
        menuViewCell = [nib objectAtIndex:0];
    }
    
    NSString* actionTitle = [[actionArray objectAtIndex:(indexPath.row)]objectForKey:SIDEBAR_TITLE_TAG];
    NSString* actionIcon  = [[actionArray objectAtIndex:(indexPath.row)]objectForKey:SIDEBAR_ICON_TAG];
    
    if (selectedIndex == indexPath.row){
        [menuViewCell.actionTitle setTextColor:[UIColor darkGrayColor]];
    }else{
        [menuViewCell.actionTitle setTextColor:[UIColor lightGrayColor]];
    }
    
    [menuViewCell.actionTitle setText:actionTitle];
    [menuViewCell.actionIcon  setImage:[UIImage imageNamed:actionIcon]];
    
    return menuViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case SIDEBAR_PROFILE_ITEM:
            [self performSegueWithIdentifier:@"UserProfileSegue" sender:nil];
            selectedIndex = SIDEBAR_PROFILE_ITEM;
            break;
        case SIDEBAR_CHAT_ITEM:
            //[self performSegueWithIdentifier:@"spotsSegue" sender:self];
            selectedIndex = SIDEBAR_CHAT_ITEM;
            break;
        case SIDEBAR_PEOPLENEARBY_ITEM:
            //[self performSegueWithIdentifier:@"accountSegue" sender:self];
            selectedIndex = SIDEBAR_PEOPLENEARBY_ITEM;
            break;
        case SIDEBAR_FRIENDSNEARBY_ITEM:
            selectedIndex = SIDEBAR_FRIENDSNEARBY_ITEM;
            break;
        case SIDEBAR_OFFERS_ITEM:
            selectedIndex = SIDEBAR_OFFERS_ITEM;
            break;
        case SIDEBAR_FRIENDREQUESTS_ITEM:
            selectedIndex = SIDEBAR_FRIENDREQUESTS_ITEM;
            break;
        case SIDEBAR_SETTINGS_ITEM:
            [self performSegueWithIdentifier:@"ManageSettingSegue" sender:self];
            selectedIndex = SIDEBAR_SETTINGS_ITEM;
            break;
        case SIDEBAR_LOGOUT_ITEM:
            [SHAlertHelper showOkCancelAlertViewWithTitle:@"Confirmation" message:@"Are you sure you want to Logout?" onOk:^(void){
                selectedIndex = SIDEBAR_PROFILE_ITEM;
                [[UserInformation sharedInstance] removeInformation];
                //elf performSegueWithIdentifier:@"splashSegue" sender:self];
            }onCancel:^(void){
                NSLog(@"Cancel operation");
            }];
            break;
    }
    
    [self.menuTableView reloadData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MenuViewCell cellHeight];
}


#pragma mark - private functions
- (void)Initialize
{
    
    actionArray = @[@{SIDEBAR_TITLE_TAG : SIDEBAR_PROFILE_TITLE,         SIDEBAR_ICON_TAG : SIDEBAR_PROFILE_ICON        },
                    @{SIDEBAR_TITLE_TAG : SIDEBAR_CHAT_TITLE,            SIDEBAR_ICON_TAG : SIDEBAR_CHAT_ICON        },
                    @{SIDEBAR_TITLE_TAG : SIDEBAR_PEOPLENEARBY_TITLE,    SIDEBAR_ICON_TAG : SIDEBAR_PEOPLENEARBY_ICON        },
                    @{SIDEBAR_TITLE_TAG : SIDEBAR_FRIENDSNEARBY_TITLE,   SIDEBAR_ICON_TAG : SIDEBAR_FRIENDSNEARBY_ICON       },
                    @{SIDEBAR_TITLE_TAG : SIDEBAR_OFFERS_TITLE,          SIDEBAR_ICON_TAG : SIDEBAR_OFFERS_ICON     },
                    @{SIDEBAR_TITLE_TAG : SIDEBAR_FRIENDREQUESTS_TITLE,  SIDEBAR_ICON_TAG : SIDEBAR_FRIENDREQUESTS_ICON       },
                    @{SIDEBAR_TITLE_TAG : SIDEBAR_SETTINGS_TITLE,        SIDEBAR_ICON_TAG : SIDEBAR_SETTINGS_ICON     },
                    @{SIDEBAR_TITLE_TAG : SIDEBAR_LOGOUT_TITLE,          SIDEBAR_ICON_TAG : SIDEBAR_LOGOUT_ICON     }];
    
    selectedIndex = 0;
    
    [self.menuTableView.backgroundView setBackgroundColor:UIColorFromRGB(0xEFEFF4)];
    
    UIImage* userImage = [UIImage imageNamed:@"user"];
    [_photoView setImage:userImage];
    
    
    if ([self.menuTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.menuTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.menuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.menuTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


@end
