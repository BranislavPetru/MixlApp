//
//  LoginEmailViewController.m
//  Mixl
//
//  Created by admin on 4/7/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "LoginEmailViewController.h"

@interface LoginEmailViewController ()

@end

@implementation LoginEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewUsername.layer.cornerRadius = 4.0f;
    _viewPassword.layer.cornerRadius = 4.0f;
    _btnLogin.layer.cornerRadius = 4.0f;
    _btnLogin.layer.borderWidth = 1.5f;
    _btnLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.txtUserName.delegate = self;
    self.txtPassword.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginClicked:(id)sender {
    
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
