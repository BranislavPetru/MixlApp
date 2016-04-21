//
//  OffersViewController.h
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersViewController : BaseViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *txtOfferName;
@property (weak, nonatomic) IBOutlet UITextView *txtviewOffer;
@property (weak, nonatomic) IBOutlet UIButton *btnPreview;

@end
