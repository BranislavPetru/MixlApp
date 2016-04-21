//
//  ViewOfferViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "ViewOfferViewController.h"

@interface ViewOfferViewController ()

@end

@implementation ViewOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void) initView{
    _btnSave.layer.borderWidth = 2.0f;
    _btnSave.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnCancel.layer.borderWidth = 2.0f;
    _btnCancel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    if(_offer != nil)
    {
        _lblOfferName.text = [NSString stringWithFormat:@"Your Offer:%@", [_offer objectForKey:@"name"]];
        if([[_offer objectForKey:@"image"] isEqualToString:@""]){
             [_imgVenue setImage:[UIImage imageNamed:@"bar"]];
        }
        else{
            [_imgVenue setImage:[commonUtils decodeBase64ToImage:[_offer objectForKey:@"image"]]];
        }
    }
    else{
        _lblOfferName.text = [NSString stringWithFormat:@"Your Offer"];
        [_imgVenue setImage:[UIImage imageNamed:@"bar"]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveClicked:(id)sender {
    NSMutableArray *offers = [[NSMutableArray alloc] init];
    offers = appController.offersList;
    [offers addObject:_offer];
    appController.offersList = offers;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelClicked:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

@end
