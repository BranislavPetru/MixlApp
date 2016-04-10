//
//  UserRegistrationViewController.m
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserRegistrationViewController.h"

@interface UserRegistrationViewController (){
    NSArray *monthList;
    NSMutableArray *dayList;
    NSMutableArray *yearList;
}

@end

@implementation UserRegistrationViewController

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

    _viewComponent.layer.borderWidth = 2.0f;
    _viewComponent.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewTerms.layer.borderWidth = 2.0f;
    _viewTerms.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewPolicy.layer.borderWidth = 2.0f;
    _viewPolicy.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnDone.layer.borderWidth = 2.0f;
    _btnDone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    monthList = @[@"Jan", @"Feb", @"Mar", @"Aprl", @"May", @"June", @"Jul", @"Aug", @"Sep", @"Oct", @"Nob", @"Dec" ];
    dayList = [[NSMutableArray alloc] init];
    yearList = [[NSMutableArray alloc] init];
    NSInteger year = [components year];
    for(int d = 1 ; d <= 31; d++)
        [dayList addObject:[NSString stringWithFormat:@"%d", d]];
    for(int y = (int)year ; y >= 1930; y--)
        [yearList addObject:[NSString stringWithFormat:@"%d", y]];
    
    _txtMonth.text = [monthList objectAtIndex:((int)[components month] -1)];
    _txtDay.text = [NSString stringWithFormat:@"%d", (int)[components day]];
    _txtYear.text = [NSString stringWithFormat:@"%d", (int)[components year]];
    
    _tableViewMonth.hidden = YES;
    _tableViewMonth.layer.borderWidth = 1.0f;
    _tableViewMonth.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _tableviewDay.hidden = YES;
    _tableviewDay.layer.borderWidth = 1.0f;
    _tableviewDay.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _tableviewYear.hidden = YES;
    _tableviewYear.layer.borderWidth = 1.0f;
    _tableviewYear.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    [_btnMale setImage:[UIImage imageNamed:@"icon_unclickcircle"] forState:UIControlStateNormal];
    [_btnMale setImage:[UIImage imageNamed:@"icon_clickcircle"] forState:UIControlStateSelected];
    [_btnFemale setImage:[UIImage imageNamed:@"icon_unclickcircle"] forState:UIControlStateNormal];
    [_btnFemale setImage:[UIImage imageNamed:@"icon_clickcircle"] forState:UIControlStateSelected];
    
    _btnMale.selected = YES;
    _btnFemale.selected = NO;
    
    self.swTerms.on = NO;
    self.swPolicy.on = NO;
    
    _txtFullName.delegate = self;
    _txtEmail.delegate = self;
    _txtPassword.delegate = self;
    _txtConfirmPassword.delegate = self;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onbtnMenuClicked:(id)sender {
    [self.revealViewController revealToggleAnimated:YES];
}

- (IBAction)monthClicked:(id)sender {
    
    if (_tableViewMonth.hidden == YES) {
        _tableViewMonth.hidden = NO;
    }else {
        _tableViewMonth.hidden = YES;
    }
}

- (IBAction)dayClicked:(id)sender {
    if (_tableviewDay.hidden == YES) {
        _tableviewDay.hidden = NO;
    }else {
        _tableviewDay.hidden = YES;
    }
}

- (IBAction)yearClicked:(id)sender {
    if (_tableviewYear.hidden == YES) {
        _tableviewYear.hidden = NO;
    }else {
        _tableviewYear.hidden = YES;
    }
}

- (IBAction)maleClicked:(id)sender {
    _btnMale.selected = !_btnMale.selected;
    _btnFemale.selected = !_btnMale.selected;
}

- (IBAction)femailClicked:(id)sender {
    _btnFemale.selected = !_btnFemale.selected;
    _btnMale.selected = !_btnFemale.selected;
}




- (IBAction)onSWTerms:(id)sender {
    //[UserInformation sharedInstance].receiveMessage = self.swTerms.on;
}

- (IBAction)onSWPolicy:(id)sender {
    //[UserInformation sharedInstance].receiveMessage = self.swPolicy.on;
}

- (IBAction)doneClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma UITableViewDelegate Method
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numRow;
    if (tableView == _tableViewMonth) {
        numRow = monthList.count;
    }
    else
    {
        if (tableView == _tableviewDay)
            numRow = dayList.count;
        else
            numRow = yearList.count;
    }
    return numRow;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (tableView == _tableViewMonth) {
        cell.textLabel.text = [monthList objectAtIndex:indexPath.row];
    }
    else
    {
        if (tableView == _tableviewDay)
            cell.textLabel.text = [dayList objectAtIndex:indexPath.row];
        else
            cell.textLabel.text = [yearList objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.hidden = YES;
    if (tableView == _tableViewMonth) {
        _txtMonth.text = [monthList objectAtIndex:indexPath.row];
    }
    else
    {
        if (tableView == _tableviewDay)
            _txtDay.text = [dayList objectAtIndex:indexPath.row];
        else
            _txtYear.text = [yearList objectAtIndex:indexPath.row];
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
