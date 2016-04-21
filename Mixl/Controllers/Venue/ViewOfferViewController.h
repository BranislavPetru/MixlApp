//
//  ViewOfferViewController.h
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewOfferViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgVenue;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferName;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (strong, nonatomic) NSDictionary *offer;
@end
