//
//  BusinessRegistrationViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "BusinessRegistrationViewController.h"

@interface BusinessRegistrationViewController () 

@end

@implementation BusinessRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView {
    
    _viewComponent.layer.borderWidth = 2.0f;
    _viewComponent.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewTerms.layer.borderWidth = 2.0f;
    _viewTerms.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewPolicy.layer.borderWidth = 2.0f;
    _viewPolicy.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnDone.layer.borderWidth = 2.0f;
    _btnDone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.swTerms.on = NO;
    self.swPolicy.on = NO;
    
}

- (IBAction)onSWTerms:(id)sender {
    //[UserInformation sharedInstance].receiveMessage = self.swTerms.on;
}

- (IBAction)onSWPolicy:(id)sender {
    //[UserInformation sharedInstance].receiveMessage = self.swPolicy.on;
}

- (IBAction)doneClicked:(id)sender {
    // sign up
    [self venuenavToMainView];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
