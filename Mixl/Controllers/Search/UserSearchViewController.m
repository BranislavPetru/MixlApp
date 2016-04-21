//
//  UserSearchViewController.m
//  Mixl
//
//  Created by admin on 4/10/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserSearchViewController.h"
#import "UsersViewViewController.h"
#import "PeopleTableViewCell.h"
#import "FriendsCollectionViewCell.h"

@interface UserSearchViewController ()

@property (nonatomic, strong) NSMutableArray *peoplesNearBy, *Friends;

@end

@implementation UserSearchViewController
@synthesize peoplesNearBy, Friends;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    peoplesNearBy = appController.peoplesNearby;
    Friends = appController.Friends;
    [self initView];
}

- (void) initView {
    
    _viewSearch.layer.cornerRadius = 3.0f;
    _viewSearch.layer.borderWidth = 1.5f;
    _viewSearch.layer.borderColor = [UIColor whiteColor].CGColor;
    
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
    
    self.lblPeopleNearby.textColor = (show) ? [UIColor whiteColor]:UIColorFromRGB(0xF5F8EE);
    self.viewPeopleTab.backgroundColor = (show) ? UIColorFromRGB(0x55E0E0) : UIColorFromRGB(0x43C6DB);
    
    self.lblFriends.textColor = (show) ?  UIColorFromRGB(0xF5F8EE):[UIColor whiteColor];
    self.viewFriendsTab.backgroundColor = (show) ? UIColorFromRGB(0x43C6DB):UIColorFromRGB(0x55E0E0);
    
    _viewPeopleNearby.hidden = !show;
    _viewFriends.hidden = show;
    
}


- (IBAction)searchClicked:(id)sender {
    _lblSearch.hidden = YES;
    _btnSearch.hidden = YES;
    [_txtSearch becomeFirstResponder];
}

- (IBAction)onPeopleTapClicked:(id)sender {
    [self showTap:YES];
}

- (IBAction)onFriendsTapClicked:(id)sender {
    [self showTap:NO];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [peoplesNearBy count];
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PeopleTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PeopleCell"];
    
    NSMutableDictionary *dic = [peoplesNearBy objectAtIndex:indexPath.row];
    
    [cell.lblPeopleName setText:[NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"fname"], [dic objectForKey:@"lname"]]];
    [cell.lblPeopleAge setText:[NSString stringWithFormat:@"Age: %@", [dic objectForKey:@"age"]]];
    [cell.lblPeopleLocation setText:[NSString stringWithFormat:@"%@ mi", [dic objectForKey:@"distance"]]];

    NSString *image1 = [dic objectForKey:@"image1"];
    [cell.imgPeople setImage:[UIImage imageNamed:image1]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UsersViewViewController* userViewViewController =
    (UsersViewViewController*) [storyboard instantiateViewControllerWithIdentifier:@"UsersViewVC"];
    userViewViewController.userInfo = [peoplesNearBy objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:userViewViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([[UIScreen mainScreen] bounds].size.height) / 2.0 - 40;
}

#pragma - mark
#pragma - mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [Friends count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width) / 2.0;
    CGFloat height = width * 125 / 160;
    return CGSizeMake(width, height);
}

#pragma - mark UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FiendsCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[FriendsCollectionViewCell alloc] init];
    }
    NSMutableDictionary *dic = [Friends objectAtIndex:indexPath.row];
    
    NSString *image = [dic objectForKey:@"image"];
    if (image != nil) {    //!= [NSNull null]
        [cell.imgFriend setImage:[UIImage imageNamed:image]];
        
    } else {
        cell.imgFriend.image = [UIImage imageNamed:@"user"];
    }
    
    if ([[dic objectForKey:@"status"] isEqualToString:@"online"]) {    //!= [NSNull null]
        [cell.imgStatus setImage:[UIImage imageNamed:@"icon_circlegreen"]];
        
    } else {
        cell.imgStatus.image = [UIImage imageNamed:@"icon_circlered"];
    }

    cell.lblName.text = [NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"fname"], [dic objectForKey:@"lname"]];
    cell.lblDistance.text = [NSString stringWithFormat:@"%@ mi", [dic objectForKey:@"distance"]];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //current_selected = (int)indexPath.item;

}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self search:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (void) search:(NSString*)key {
    if (key.length > 0) {
        
    }
}

@end
