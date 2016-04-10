//
//  ManageSettingViewController.m
//  Mixl
//
//  Created by admin on 4/7/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "ManageSettingViewController.h"

@interface ManageSettingViewController ()

@end

@implementation ManageSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initView];
}

- (void) initView {
    
    self.revealViewController.delegate = self;
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
    [self.tapRecognizerView addGestureRecognizer:self.tapGestureRecognizer];
    self.tapGestureRecognizer.enabled = NO;
    self.tapRecognizerView.hidden = YES;
    
     [self configureStandardSlider];
    _segGander.selectedSegmentIndex = 0;
    [_btnSeeAllCheckbox setImage:[UIImage imageNamed:@"icon_uncheckbox"] forState:UIControlStateNormal];
    [_btnSeeAllCheckbox setImage:[UIImage imageNamed:@"icon_checkbox"] forState:UIControlStateSelected];
    [_btnSeeFriendsCheckbox setImage:[UIImage imageNamed:@"icon_uncheckbox"] forState:UIControlStateNormal];
    [_btnSeeFriendsCheckbox setImage:[UIImage imageNamed:@"icon_checkbox"] forState:UIControlStateSelected];
    [_btnContactAllCheckbox setImage:[UIImage imageNamed:@"icon_uncheckbox"] forState:UIControlStateNormal];
    [_btnContactAllCheckbox setImage:[UIImage imageNamed:@"icon_checkbox"] forState:UIControlStateSelected];
    [_btnContactFriendsCheckbox setImage:[UIImage imageNamed:@"icon_uncheckbox"] forState:UIControlStateNormal];
    [_btnContactFriendsCheckbox setImage:[UIImage imageNamed:@"icon_checkbox"] forState:UIControlStateSelected];
    //self.swReceiveMsg.on = [UserInformation sharedInstance].receiveMessage;
    //self.swReceiveMsg.on = [UserInformation sharedInstance].receiveMessage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (IBAction)onbtnMenuClicked:(id)sender {
    [self.revealViewController revealToggleAnimated:YES];
}

#pragma mark -
#pragma mark - Standard Slider

- (void) configureStandardSlider
{
    self.standardSlider.lowerValue = 0.21;
    self.standardSlider.upperValue = 0.35;
    _lblAgeRange.text = [NSString stringWithFormat:@"%d-%d.",(int)((float)self.standardSlider.lowerValue * 100),(int)((float)self.standardSlider.upperValue * 100)];
}

- (IBAction)radiusSlider:(UISlider *)sender {
    int value = [sender value];
    _lblRadius.text = [NSString stringWithFormat:@"%dmi.",value];
}

- (IBAction)ageRangeSlider:(NMRangeSlider*)sender
{
    _lblAgeRange.text = [NSString stringWithFormat:@"%d-%d.",(int)((float)self.standardSlider.lowerValue * 100),(int)((float)self.standardSlider.upperValue * 100)];
}

- (IBAction)onGenderChanged:(id)sender {
    int m_Gender = (int)_segGander.selectedSegmentIndex;
}

- (IBAction)onSeeAllCheckBoxToggle:(id)sender
{
    _btnSeeAllCheckbox.selected = !_btnSeeAllCheckbox.selected;
    _btnSeeFriendsCheckbox.selected = !_btnSeeAllCheckbox.selected;
}

- (IBAction)onSeeFriendsCheckBoxToggle:(id)sender
{
    _btnSeeFriendsCheckbox.selected = !_btnSeeFriendsCheckbox.selected;
    _btnSeeAllCheckbox.selected = !_btnSeeFriendsCheckbox.selected;
}

- (IBAction)onContactAllCheckBoxToggle:(id)sender
{
    _btnContactAllCheckbox.selected = !_btnContactAllCheckbox.selected;
    _btnContactFriendsCheckbox.selected = !_btnContactAllCheckbox.selected;
}

- (IBAction)onContactFriendsCheckBoxToggle:(id)sender
{
    _btnContactFriendsCheckbox.selected = !_btnContactFriendsCheckbox.selected;
    _btnContactAllCheckbox.selected = !_btnContactFriendsCheckbox.selected;
}

- (IBAction)onFriendRequest:(id)sender {
    //[UserInformation sharedInstance].receiveMessage = self.swFriendRequest.on;
}

- (IBAction)onInvitesUsers:(id)sender {
    //[UserInformation sharedInstance].receiveMessage = self.swInvitesUsers.on;
}

- (IBAction)onShareMixlClick:(id)sender
{
    
}

- (IBAction)onDoneClick:(id)sender
{
    
}

- (IBAction)onDeleteAccountClick:(id)sender
{
   
}

#pragma mark - SWRevealViewController Delegate Methods
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if (position == FrontViewPositionRight) {         // Menu will get revealed
        self.tapGestureRecognizer.enabled = YES;      // Enable the tap gesture Recognizer
        self.tapRecognizerView.hidden = NO;
    }
    else if (position == FrontViewPositionLeft){      // Menu will close
        self.tapGestureRecognizer.enabled = NO;       // Enable the tap gesture Recognizer
        self.tapRecognizerView.hidden = YES;
    }
}



@end