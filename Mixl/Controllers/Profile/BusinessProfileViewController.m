//
//  BusinessProfileViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "BusinessProfileViewController.h"

@interface BusinessProfileViewController (){
    NSArray *cityList;
    NSArray *stateList;
}
@end

@implementation BusinessProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void) initView {
    
    _imgVenue.layer.borderWidth = 2.0f;
    _imgVenue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _viewComponent.layer.borderWidth = 2.0f;
    _viewComponent.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnNext.layer.borderWidth = 2.0f;
    _btnNext.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    cityList = @[@"New York", @"Washigton", @"Los Angles", @"San Francisco", @"Philadelphia", @"Houston", @"Atlanta", @"Baltimore", @"Chicago", @"Portland", @"New Orleans", @"Boston", @"San Jose", @"Denver" ];
    stateList = @[@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming"];
    
    _tableViewCity.hidden = YES;
    _tableViewCity.layer.borderWidth = 1.0f;
    _tableViewCity.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _tableviewState.hidden = YES;
    _tableviewState.layer.borderWidth = 1.0f;
    _tableviewState.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    _txtviewAbout.text = @"About Us";
    _txtviewAbout.textColor = [UIColor lightGrayColor];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)cityClicked:(id)sender {
    if (_tableViewCity.hidden == YES) {
        _tableViewCity.hidden = NO;
        _tableviewState.hidden = YES;
    }else {
        _tableViewCity.hidden = YES;
    }
}
- (IBAction)stateClicked:(id)sender {
    if (_tableviewState.hidden == YES) {
        _tableviewState.hidden = NO;
        _tableViewCity.hidden = YES;
    }else {
        _tableviewState.hidden = YES;
    }
}

- (IBAction)doneClicked:(id)sender {
    // profile update
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BusinessSettingViewController *businessSettingViewController =
    (BusinessSettingViewController*) [storyboard instantiateViewControllerWithIdentifier:@"BusinessSettingVC"];
    [self.navigationController pushViewController:businessSettingViewController animated:YES];
}

#pragma UITableViewDelegate Method
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numRow;
    if (tableView == _tableViewCity) {
        numRow = cityList.count;
    }
    else
    {
        numRow = stateList.count;
    }
    return numRow;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    if (tableView == _tableViewCity) {
        cell.textLabel.text = [cityList objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [stateList objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.hidden = YES;
    if (tableView == _tableViewCity) {
        _txtCity.text = [cityList objectAtIndex:indexPath.row];
    }
    else
    {
        _txtState.text = [stateList objectAtIndex:indexPath.row];
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    if([_txtviewAbout.text isEqualToString:@"About Us"])
    {
        _txtviewAbout.text = @"";
        _txtviewAbout.textColor = [UIColor blackColor];
    }
    [_txtviewAbout becomeFirstResponder];
}

- (void) textViewDidEndEditing:(UITextView *)textView
{   if([_txtviewAbout.text isEqualToString:@""])
{
    _txtviewAbout.text = @"About Us";
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
    [_imgVenue setImage:imageSEL];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
