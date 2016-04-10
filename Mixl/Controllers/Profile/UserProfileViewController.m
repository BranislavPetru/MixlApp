//
//  UserProfileViewController.m
//  Mixl
//
//  Created by admin on 4/6/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController (){
    
    NSArray *monthList;
    NSMutableArray *dayList;
    NSMutableArray *yearList;
    BOOL txtFullNameflag, txtEmailflag, txtPassflag, txtAboutflag;
}

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.revealViewController.delegate = self;
    [self initView];
}

- (void) initView {
    
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
    [self.tapRecognizerView addGestureRecognizer:self.tapGestureRecognizer];
    self.tapGestureRecognizer.enabled = YES;
    self.tapRecognizerView.hidden = YES;
    
    _imgUser.layer.borderWidth = 2.0f;
    _imgUser.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewComponent.layer.borderWidth = 2.0f;
    _viewComponent.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
    
    _txtFullName.delegate = self;
    _txtEmail.delegate = self;
    _txtPassword.delegate = self;
    _txtviewAbout.delegate = self;
    _txtviewAbout.text = @"Tell users a little about yourself...";
    _txtviewAbout.textColor = [UIColor lightGrayColor];
    txtFullNameflag = NO;
    txtEmailflag = NO;
    txtPassflag = NO;
    txtAboutflag = NO;
    
    self.revealViewController.delegate = self;
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.revealViewController action:@selector(revealToggle:)];
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

- (IBAction)nameEditClicked:(id)sender {
    _txtFullName.text = @"";
    txtFullNameflag = YES;
    [_txtFullName becomeFirstResponder];
}

- (IBAction)emailEditClicked:(id)sender {
    _txtEmail.text = @"";
    txtEmailflag = YES;
    [_txtEmail becomeFirstResponder];
}

- (IBAction)passEditClicked:(id)sender {
    _txtPassword.text = @"";
    txtPassflag = YES;
    [_txtPassword becomeFirstResponder];
}

- (IBAction)aboutEditClicked:(id)sender {
    _txtviewAbout.text = @"";
    txtAboutflag = YES;
    [_txtviewAbout becomeFirstResponder];
}

- (IBAction)maleClicked:(id)sender {
    _btnMale.selected = !_btnMale.selected;
    _btnFemale.selected = !_btnMale.selected;
}

- (IBAction)femailClicked:(id)sender {
    _btnFemale.selected = !_btnFemale.selected;
    _btnMale.selected = !_btnFemale.selected;
}

- (IBAction)photouploadClicked:(id)sender {
    UIActionSheet *alertCamera = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Take a picture",
                   @"Select photos from camera roll", nil];
    alertCamera.tag = 1;
    [alertCamera showInView:[UIApplication sharedApplication].keyWindow];
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

#pragma UITextFieldDelegate methods
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _txtFullName) {
        if (txtFullNameflag) {
            return YES;
        }else {
            return NO;
        }
    }
    else{
        if (textField == _txtEmail) {
            if (txtEmailflag) {
                return YES;
            }else {
                return NO;
            }
        }
        else
        {
            if (txtPassflag) {
                return YES;
            }else {
                return NO;
            }
        }
    }
}

#pragma UITextViewDelegate methods
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (txtAboutflag) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    if([_txtviewAbout.text isEqualToString:@"Tell users a little about yourself..."])
    {
        _txtviewAbout.text = @"";
        _txtviewAbout.textColor = [UIColor blackColor];
    }
    [_txtviewAbout becomeFirstResponder];
}

- (void) textViewDidEndEditing:(UITextView *)textView
{   if([_txtviewAbout.text isEqualToString:@""])
    {
        _txtviewAbout.text = @"Tell users a little about yourself...";
        _txtviewAbout.textColor = [UIColor lightGrayColor];
    }
    [_txtviewAbout resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    switch (buttonIndex) {
            
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            
        default:
            break;
    }
    
    NSLog(@"%ld , %ld", (long)actionSheet.tag , (long)buttonIndex);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *imageSEL = info[UIImagePickerControllerEditedImage];
    [_imgUser setImage:imageSEL];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - SWRevealViewController Delegate Methods
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if (position == FrontViewPositionRight) {         // Menu will get revealed
//        self.tapGestureRecognizer.enabled = YES;      // Enable the tap gesture Recognizer
        self.tapRecognizerView.hidden = NO;
    }
    else if (position == FrontViewPositionLeft){      // Menu will close
//        self.tapGestureRecognizer.enabled = NO;       // Enable the tap gesture Recognizer
        self.tapRecognizerView.hidden = YES;
    }
}

@end
