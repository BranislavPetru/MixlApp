//
//  LoginViewController.m
//  Mixl
//
//  Created by admin on 4/6/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewFBSignin.layer.cornerRadius = 3.0f;
    _viewFBSignin.layer.borderWidth = 1.5f;
    _viewFBSignin.layer.borderColor = [UIColor whiteColor].CGColor;
    _viewF.layer.borderWidth = 1.5f;
    _viewF.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _viewLogin.layer.cornerRadius = 3.0f;
    _viewLogin.layer.borderWidth = 1.5f;
    _viewLogin.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFBSignInClicked:(id)sender {
    //[self performSegueWithIdentifier:@"facebookSegue" sender:nil];
}

- (IBAction)onLoginClicked:(id)sender {
    [self performSegueWithIdentifier:@"LoginSegue" sender:nil];

}

- (IBAction)onRegisterClicked:(id)sender {
    [self performSegueWithIdentifier:@"UserRegistrationSegue" sender:nil];
}

- (IBAction)onBusinessRegisterClicked:(id)sender {
    
}

@end
