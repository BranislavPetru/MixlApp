//
//  OffersViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "OffersViewController.h"
#import "ViewOfferViewController.h"

@interface OffersViewController (){
    NSString *image;
}

@end

@implementation OffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    image = @"";
    _txtviewOffer.layer.borderWidth = 2.0f;
    _txtviewOffer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnPreview.layer.borderWidth = 2.0f;
    _btnPreview.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)previewClicked:(id)sender {
    if([commonUtils isFormEmpty:[@[_txtOfferName.text, _txtviewOffer.text] mutableCopy]]) {
        [commonUtils showVAlertSimple:@"Warning" body:@"Please complete entire form" duration:1.2];
    }
    else{
        NSMutableDictionary* newOffer = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_txtOfferName.text, @"name",
                                                                                                   @"00:45:45", @"time",
                                                                                                         image, @"image",
                                                                                                 _txtviewOffer, @"description",nil];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewOfferViewController* viewOfferViewController =
        (ViewOfferViewController*) [storyboard instantiateViewControllerWithIdentifier:@"ViewOffersVC"];
        viewOfferViewController.offer = newOffer;
        [self.navigationController pushViewController:viewOfferViewController animated:YES];
    }
}

- (IBAction)mixlGalleryClicked:(id)sender {
    UIActionSheet *alertCamera = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take a picture",
                                  @"Select photos from camera roll", nil];
    alertCamera.tag = 1;
    [alertCamera showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)ownImageClicked:(id)sender {
    UIActionSheet *alertCamera = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take a picture",
                                  @"Select photos from camera roll", nil];
    alertCamera.tag = 1;
    [alertCamera showInView:[UIApplication sharedApplication].keyWindow];
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
    //[_imgVenue setImage:imageSEL];
   image = [commonUtils encodeToBase64String:imageSEL byCompressionRatio:1.0];
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
