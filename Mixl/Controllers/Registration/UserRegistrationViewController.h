//
//  UserRegistrationViewController.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface UserRegistrationViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewComponent;
@property (strong, nonatomic) IBOutlet UIView *viewTerms;
@property (strong, nonatomic) IBOutlet UIView *viewPolicy;
@property (strong, nonatomic) IBOutlet UITableView *tableViewMonth;
@property (strong, nonatomic) IBOutlet UITableView *tableviewDay;
@property (strong, nonatomic) IBOutlet UITableView *tableviewYear;
@property (strong, nonatomic) IBOutlet UITextField *txtMonth;
@property (strong, nonatomic) IBOutlet UITextField *txtDay;
@property (strong, nonatomic) IBOutlet UITextField *txtYear;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirmPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnMale;
@property (strong, nonatomic) IBOutlet UIButton *btnFemale;
@property (nonatomic, strong) IBOutlet UISwitch*                swTerms;
@property (nonatomic, strong) IBOutlet UISwitch*                swPolicy;

@property (strong, nonatomic) IBOutlet UIView           *tapRecognizerView;
@property (strong, nonatomic) IBOutlet UIButton* sideBarButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end
