//
//  ClaimedVouchersViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "ClaimedVouchersViewController.h"
#import "ClaimedTableViewCell.h"
#import "NotClaimedTableViewCell.h"
#import "AcceptedOfferViewController.h"

@interface ClaimedVouchersViewController ()

@property (nonatomic, strong) NSMutableArray *claimedUsers, *notclaimedUsers;

@end

@implementation ClaimedVouchersViewController
@synthesize claimedUsers, notclaimedUsers;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    claimedUsers = appController.claimedUsers;
    notclaimedUsers = appController.notclaimedUsers;
    [self initView];
}

- (void) initView {
    
    if(_tapType == 2)
    {
        [self showTap:YES];
    }
    else
    {
        [self showTap:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTap:(BOOL)show {
    
    self.lblClaimed.textColor = (show) ? [UIColor whiteColor]:UIColorFromRGB(0xF5F8EE);
    self.viewClaimedTab.backgroundColor = (show) ? UIColorFromRGB(0x55E0E0) : UIColorFromRGB(0x43C6DB);
    
    self.lblNotClaimed.textColor = (show) ?  UIColorFromRGB(0xF5F8EE):[UIColor whiteColor];
    self.viewNotClaimedTab.backgroundColor = (show) ? UIColorFromRGB(0x43C6DB):UIColorFromRGB(0x55E0E0);
    
    _viewClaimed.hidden = !show;
    _viewNotClaimed.hidden = show;
    
}


- (IBAction)onClaimedTapClicked:(id)sender {
    [self showTap:YES];
}

- (IBAction)onNotClaimedTapClicked:(id)sender {
    [self showTap:NO];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _tableClaimed){
        return [claimedUsers count];
    }
    else{
        return [notclaimedUsers count];
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _tableClaimed){
        ClaimedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ClaimedCell"];
        
        NSMutableDictionary *dic = [claimedUsers objectAtIndex:indexPath.row];
        
        [cell.lblName setText:[NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"fname"], [dic objectForKey:@"lname"]]];
        [cell.lblAge setText:[NSString stringWithFormat:@"Age: %@", [dic objectForKey:@"age"]]];
        [cell.lblOfferName setText:[NSString stringWithFormat:@"%@", [dic objectForKey:@"offername"]]];
        
        NSString *image = [dic objectForKey:@"image"];
        [cell.imgUser setImage:[UIImage imageNamed:image]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        NotClaimedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NotClaimedCell"];
        
        NSMutableDictionary *dic = [notclaimedUsers objectAtIndex:indexPath.row];
        
        [cell.lblName setText:[NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"fname"], [dic objectForKey:@"lname"]]];
        [cell.lblAge setText:[NSString stringWithFormat:@"Age: %@", [dic objectForKey:@"age"]]];
        [cell.lblOfferName setText:[NSString stringWithFormat:@"%@", [dic objectForKey:@"offername"]]];
         [cell.lblTime setText:[NSString stringWithFormat:@"%@", [dic objectForKey:@"time"]]];
        
        NSString *image = [dic objectForKey:@"image"];
        [cell.imgUser setImage:[UIImage imageNamed:image]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == _tableClaimed){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AcceptedOfferViewController* acceptedofferViewController =
        (AcceptedOfferViewController*) [storyboard instantiateViewControllerWithIdentifier:@"AcceptedOfferVC"];
        acceptedofferViewController.offeredUser = [claimedUsers objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:acceptedofferViewController animated:YES];

    }
}

@end
