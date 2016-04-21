//
//  UsersViewViewController.m
//  Mixl
//
//  Created by Jose on 4/19/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UsersViewViewController.h"

@interface UsersViewViewController ()

@end

@implementation UsersViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initView{
    _btnAddList.layer.borderWidth = 3.0f;
    _btnAddList.layer.cornerRadius = 4.0f;
    _btnAddList.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _lblUserName.text = [NSString stringWithFormat:@"%@ %@", [self.userInfo objectForKey:@"fname"], [self.userInfo objectForKey:@"lname"]];
    _lblUserAge.text = [NSString stringWithFormat:@"Age: %@", [self.userInfo  objectForKey:@"age"]];
    if([[self.userInfo  objectForKey:@"gender"] isEqualToString:@"m"]){
        _lblUserGender.text = @"Gender: Male";
    }
    else{
        _lblUserGender.text = @"Gender: Female";
    }
    _txtUserAbout.text = [self.userInfo objectForKey:@"description"];
    
    NSString *image1 = [self.userInfo objectForKey:@"image1"];
    [_imgUserPic setImage:[UIImage imageNamed:image1]];
}

- (IBAction)closeClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addListClicked:(id)sender {
    //add friend api
    
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

@end
