//
//  PeopleNearbyViewController.m
//  Mixl
//
//  Created by Jose on 4/20/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "PeopleNearbyViewController.h"
#import "CurrentOffersCollectionViewCell.h"
#import "OffersTableViewCell.h"

@interface PeopleNearbyViewController ()
{
    int selectedIndex;
    NSMutableArray *offeredUsers;
}
@end

@implementation PeopleNearbyViewController
@synthesize peoplesNearBy, offersList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    peoplesNearBy = appController.peoplesNearby;
    offersList = appController.offersList;
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView{
    
    selectedIndex = 0;
    _viewCurrentOffers.hidden = YES;
    _btnDone.layer.borderWidth = 2.0f;
    _btnDone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnDone.layer.cornerRadius = 3.0f;
    
    offeredUsers = [[NSMutableArray alloc] init];
    for(int i = 0; i < [peoplesNearBy count]; i++){
        [offeredUsers addObject:@"0"];
    }
    
}
- (IBAction)allPeopleOfferSendClicked:(id)sender {
    for(int i = 0; i < offeredUsers.count; i++){
        [offeredUsers replaceObjectAtIndex:i withObject:@"1"];
    }
    [_conllectionViewPeople reloadData];

}

- (IBAction)currentOffersClicked:(id)sender {
   _viewCurrentOffers.hidden = NO;
}

- (IBAction)newOfferClicked:(id)sender {
 
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OffersViewController* offersViewController =
    (OffersViewController*) [storyboard instantiateViewControllerWithIdentifier:@"BusicessOffersVC"];
    [self.navigationController pushViewController:offersViewController animated:YES];
}

- (IBAction)offerDoneClicked:(id)sender {
    _viewCurrentOffers.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [offersList count];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OffersTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OffersCell"];
    
    NSMutableDictionary *dic = [offersList objectAtIndex:indexPath.row];
    
    [cell.lblOfferName setText:[NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]]];
    
    if (selectedIndex == indexPath.row) {
        [cell.imgOption setImage:[UIImage imageNamed:@"icon_clickcircle"]];
    }
    else{
        [cell.imgOption setImage:[UIImage imageNamed:@"icon_unclickcircle"]];
    }
    
    cell.btnView.tag = indexPath.row;
    [cell.btnView addTarget:self action:@selector(didSelectView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void) didSelectView:(UIButton *) sender {
    // sender.tag
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndex = (int)indexPath.row;
    [_tableViewOffers reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma - mark
#pragma - mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [peoplesNearBy count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width) / 2.0;
    CGFloat height = width * 125 / 160;
    return CGSizeMake(width, height);
}

#pragma - mark UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CurrentOffersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentOffersCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CurrentOffersCollectionViewCell alloc] init];
    }
    NSMutableDictionary *dic = [peoplesNearBy objectAtIndex:indexPath.row];
    
    NSString *image = [dic objectForKey:@"image1"];
    if (image != nil) {    //!= [NSNull null]
        [cell.imgUser setImage:[UIImage imageNamed:image]];
        
    } else {
        cell.imgUser.image = [UIImage imageNamed:@"user"];
    }
    
    if([[offeredUsers objectAtIndex:indexPath.row] isEqualToString:@"1"]){
        cell.viewAlpha.alpha = 0.5;
    }
    else{
        cell.viewAlpha.alpha = 0;
    }
    
    cell.lblUserName.text = [NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"fname"], [dic objectForKey:@"lname"]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for(int i = 0; i < offeredUsers.count; i++){
        if(i == indexPath.row) [offeredUsers replaceObjectAtIndex:i withObject:@"1"];
    }
    [_conllectionViewPeople reloadData];
}


@end
