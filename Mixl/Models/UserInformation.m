//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "UserInformation.h"
#import "RedmineAPI.h"

@implementation UserInformation

+(UserInformation*)sharedInstance
{
    static UserInformation *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id) init {
    self = [super init];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.loggedIn              = [[self.userDefaults objectForKey:@"LOGGED_IN"] boolValue];
    self.changelanguage        = [[[NSUserDefaults standardUserDefaults] objectForKey:@"LANGUAGE_CH"] boolValue];
    self.mobileNumber          = [self.userDefaults objectForKey:@"MOBILE_NUMBEWR"];
    self.password              = [self.userDefaults objectForKey:@"PASSWORD"];
    self.userName              = [self.userDefaults objectForKey:@"USERNAME"];
    self.accessToken           = [self.userDefaults objectForKey:@"ACCESSTOKEN"];
    self.deviceToken           = [self.userDefaults objectForKey:@"DEVICE_TOKEN"];
    [self loadSettings];
    return self;
}

- (void)removeInformation
{
    self.loggedIn              = NO;
    self.mobileNumber          = nil;
    self.password              = nil;
    self.userName              = nil;
    self.accessToken           = nil;
    
    [self.userDefaults removeObjectForKey: @"LOGGED_IN"];
    [self.userDefaults removeObjectForKey: @"MOBILE_NUMBEWR"];
    [self.userDefaults removeObjectForKey: @"PASSWORD"];
    [self.userDefaults removeObjectForKey: @"USERNAME"];
    [self.userDefaults removeObjectForKey: @"ACCESSTOKEN"];
    [self.userDefaults synchronize];
    return;
}

- (void)setInformation:(NSString*)mobile password:(NSString*)password user:(NSString*)userName token:(NSString*)accessToken
{
    self.loggedIn              = YES;
    self.mobileNumber          = mobile;
    self.password              = password;
    self.userName              = userName;
    self.accessToken           = accessToken;
    
    [self.userDefaults setObject:@YES forKey:@"LOGGED_IN"];
    if (mobile)        [self.userDefaults setObject:mobile forKey:@"MOBILE_NUMBEWR"];
    if (password)      [self.userDefaults setObject:password forKey:@"PASSWORD"];
    if (userName)      [self.userDefaults setObject:userName forKey:@"USERNAME"];
    else               [self.userDefaults setObject:@"" forKey:@"USERNAME"];
    if (accessToken)   [self.userDefaults setObject:accessToken forKey:@"ACCESSTOKEN"];
    [self.userDefaults synchronize];
    if (self.deviceToken != nil && self.accessToken != nil) {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      self.accessToken, @"AccessToken",
                                      self.deviceToken, @"DeviceToken", nil];
        NSLog(@"Save device token %@", self.deviceToken);
        [[BDCRedmineAPI sharedManager] registerTokenDevice:param onSuccess:^(id json) {
            NSLog(@"Save device success %@", json);
        } onFailure:^(NSInteger statusCode, id json) {
            NSLog(@"Save device fail %@", json);
        }];
    }
}

- (void)loadSettings {
    if ([self.userDefaults objectForKey:@"SECURE_SIGNIN"] == nil) {
        self.secureSignin = NO;
    }
    if ([self.userDefaults objectForKey:@"RECEIVE_MESSAGE"] == nil) {
        self.receiveMessage = YES;
    }
    if ([self.userDefaults objectForKey:@"LANGUAGE"] == nil) {
        self.language = @"en";
    }
    [self saveSettings];
}

- (void)saveSettings {
    [self.userDefaults setObject:[NSNumber numberWithBool:self.secureSignin] forKey:@"SECURE_SIGNIN"];
    [self.userDefaults setObject:[NSNumber numberWithBool:self.receiveMessage] forKey:@"RECEIVE_MESSAGE"];
    [self.userDefaults setObject:self.language forKey:@"LANGUAGE"];
    [self.userDefaults synchronize];
}

- (void)saveSettingUp{
    
    NSString* secureSet;
    NSString* receivemessageSet;
    if (self.secureSignin)
        secureSet = @"YES";
    else
        secureSet = @"NO";
    if (self.receiveMessage)
        receivemessageSet = @"YES";
    else
        receivemessageSet = @"NO";
    
    NSMutableDictionary* settingsInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:secureSet, @"SecureSignin",
                                                                               receivemessageSet, @"ReceiveMessage",
                                                                                   self.language, @"Language", nil];
    NSMutableDictionary* setting = [[NSMutableDictionary alloc] initWithObjectsAndKeys: self.accessToken, @"AccessToken",
                                                                                            settingsInfo, @"SettingsInfo", nil];
   
    [[BDCRedmineAPI sharedManager] saveSetting:setting onSuccess:^(id json) {
        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"]){
            //[self saveSettings];
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"Error save setting", nil)
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
    } onFailure:^(NSInteger statusCode, id json) {
        
    }];
    
}


- (void)setLang
{
    self.changelanguage              = YES;
    [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"LANGUAGE_CH"];
}

- (void)removeLang
{
    self.changelanguage              = NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: @"LANGUAGE_CH"];
}

- (void)saveDeviceToken:(NSString*)deviceToken {
    self.deviceToken = deviceToken;
    [self.userDefaults setObject:self.deviceToken forKey:@"DEVICE_TOKEN"];
    [self.userDefaults synchronize];
}

@end
