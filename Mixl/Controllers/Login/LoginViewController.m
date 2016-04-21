//
//  LoginViewController.m
//  Mixl
//
//  Created by admin on 4/6/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewFBSignin.layer.cornerRadius = 3.0f;
    _viewFBSignin.layer.borderWidth = 1.5f;
    _viewFBSignin.layer.borderColor = [UIColor whiteColor].CGColor;
    _viewF.layer.borderWidth = 1.5f;
    _viewF.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _viewLogin.layer.cornerRadius = 3.0f;
    _viewLogin.layer.borderWidth = 1.5f;
    _viewLogin.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFBSignInClicked:(id)sender {
    if(self.isLoadingUserBase) return;
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_birthday", @"user_photos"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in with token : @%@", result.token);
             if ([result.grantedPermissions containsObject:@"email"]) {
                 NSLog(@"result is:%@",result);
                 [self fetchUserInfo];
             }
         }
     }];

}

- (IBAction)onLoginClicked:(id)sender {
    if(self.isLoadingUserBase) return;
    [self performSegueWithIdentifier:@"EmailLoginSegue" sender:nil];
}

- (IBAction)onRegisterClicked:(id)sender {
    if(self.isLoadingUserBase) return;
    [self performSegueWithIdentifier:@"UserRegistrationSegue" sender:nil];
}

- (IBAction)onBusinessRegisterClicked:(id)sender {
    if(self.isLoadingUserBase) return;
    [self performSegueWithIdentifier:@"VenueRegistrationSegue" sender:nil];
}

- (void)fetchUserInfo {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken] tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, gender, bio, location, friends, hometown, friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"facebook fetched info : %@", result);
                 
                 NSDictionary *temp = (NSDictionary *)result;
                 //NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
                 NSMutableDictionary *userFBlogin = [[NSMutableDictionary alloc] init];
                
                  [userFBlogin setObject:[temp objectForKey:@"id"] forKey:@"fb_token"];
                  [userFBlogin setObject:[temp objectForKey:@"email"] forKey:@"email"];
                 
                  if([commonUtils getUserDefault:@"user_apns_id"] != nil) {
                      [userFBlogin setObject:[commonUtils getUserDefault:@"user_apns_id"] forKey:@"io_token"];

                      self.isLoadingUserBase = YES;
                      [commonUtils showActivityIndicatorColored:self.view];
                      //            [NSThread detachNewThreadSelector:@selector(requestData:) toTarget:self withObject:userInfo];
                      [self requestData:userFBlogin];

                  } else {
                      [appController.vAlert doAlert:@"Notice" body:@"Failed to get your device token.\nTherefore, you will not be able to receive notification for the new activities." duration:2.0f done:^(DoAlertView *alertView) {
                          
                          self.isLoadingUserBase = YES;
                          [commonUtils showActivityIndicatorColored:self.view];
                          // [NSThread detachNewThreadSelector:@selector(requestData:) toTarget:self withObject:userInfo];
                          [self requestData:userFBlogin];
                      }];
                  }

//                 [userInfo setObject:[temp objectForKey:@"id"] forKey:@"user_facebook_id"];
//                 
//                 [userInfo setObject:[temp objectForKey:@"email"] forKey:@"user_email"];
//                 
//                 if([commonUtils checkKeyInDic:@"first_name" inDic:[temp mutableCopy]]) {
//                     [userInfo setObject:[temp objectForKey:@"first_name"] forKey:@"user_first_name"];
//                 }
//                 if([commonUtils checkKeyInDic:@"last_name" inDic:[temp mutableCopy]]) {
//                     [userInfo setObject:[temp objectForKey:@"last_name"] forKey:@"user_last_name"];
//                 }
//                 
//                 NSString *gender = @"1";
//                 if([commonUtils checkKeyInDic:@"gender" inDic:[temp mutableCopy]]) {
//                     if([[temp objectForKey:@"gender"] isEqualToString:@"female"]) gender = @"2";
//                 }
//                 [userInfo setObject:gender forKey:@"user_gender"];
//                 
//                 NSString *age = @"30";
//                 if([commonUtils checkKeyInDic:@"age" inDic:[temp mutableCopy]]) {
//                     age = [NSString stringWithFormat:@"%@", [temp objectForKey:@"age"]];
//                 }
//                 [userInfo setObject:age forKey:@"user_age"];
//                 
//                 if([commonUtils getUserDefault:@"currentLatitude"] && [commonUtils getUserDefault:@"currentLongitude"]) {
//                     [userInfo setObject:[commonUtils getUserDefault:@"currentLatitude"] forKey:@"user_location_latitude"];
//                     [userInfo setObject:[commonUtils getUserDefault:@"currentLongitude"] forKey:@"user_location_longitude"];
//                 }
//                 NSString *fbProfilePhoto = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [temp objectForKey:@"id"]];
//                 [userInfo setObject:fbProfilePhoto forKey:@"user_photo_url"];
//                 
//                 [userInfo setObject:@"2" forKey:@"signup_mode"];
//                 
//                 if([commonUtils getUserDefault:@"user_apns_id"] != nil) {
//                     [userInfo setObject:[commonUtils getUserDefault:@"user_apns_id"] forKey:@"user_apns_id"];
//                     
//                     self.isLoadingUserBase = YES;
//                     [commonUtils showActivityIndicatorColored:self.view];
//                     //            [NSThread detachNewThreadSelector:@selector(requestData:) toTarget:self withObject:userInfo];
//                     [self requestData:userInfo];
//                     
//                 } else {
//                     [appController.vAlert doAlert:@"Notice" body:@"Failed to get your device token.\nTherefore, you will not be able to receive notification for the new activities." duration:2.0f done:^(DoAlertView *alertView) {
//                         
//                         self.isLoadingUserBase = YES;
//                         [commonUtils showActivityIndicatorColored:self.view];
//                         // [NSThread detachNewThreadSelector:@selector(requestData:) toTarget:self withObject:userInfo];
//                         [self requestData:userInfo];
//                     }];
//                 }
                 
             } else {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
    
}


#pragma mark - API Request - User Signup After FB Login
- (void) requestData:(id) params {
    
    NSDictionary *resObj = nil;
    resObj = [commonUtils httpJsonRequest:API_URL_USER_FBLOGIN withJSON:(NSMutableDictionary *) params];
    
    self.isLoadingUserBase = NO;
    [commonUtils hideActivityIndicator];
    
    if (resObj != nil) {
        NSDictionary *result = (NSDictionary*)resObj;
        NSDecimalNumber *status = [result objectForKey:@"status"];
        if([status intValue] == 1) {
            
            appController.currentUser = [result objectForKey:@"current_user"];
            [commonUtils setUserDefaultDic:@"current_user" withDic:appController.currentUser];
          
            [self requestOver];
            //[self performSelector:@selector(requestOver) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
            
        } else {
            NSString *msg = (NSString *)[resObj objectForKey:@"msg"];
            if([msg isEqualToString:@""]) msg = @"Please complete entire form";
            [commonUtils showVAlertSimple:@"Warning" body:msg duration:1.4];
        }
    } else {
        
//                [[FBSession activeSession] closeAndClearTokenInformation];
//                [FBSession setActiveSession:nil];
        [commonUtils showVAlertSimple:@"Connection Error" body:@"Please check your internet connection status" duration:1.0];
    }
}

- (void)requestOver {
    [self navToMainView];
}

@end
