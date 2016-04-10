//
//  LoginEmailViewController.h
//  Mixl
//
//  Created by admin on 4/7/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginEmailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIView*      viewUsername;
@property (nonatomic, strong) IBOutlet UIView*      viewPassword;
@property (nonatomic, strong) IBOutlet UIButton*    btnLogin;

@property (weak, nonatomic) IBOutlet UITextField*   txtUserName;
@property (weak, nonatomic) IBOutlet UITextField*   txtPassword;

@end
