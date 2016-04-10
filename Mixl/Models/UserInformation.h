//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject

+(UserInformation*)sharedInstance;

@property(nonatomic, assign) NSUserDefaults       *userDefaults;
@property(nonatomic, assign) BOOL       loggedIn;
@property(nonatomic, strong) NSString   *mobileNumber;
@property(nonatomic, strong) NSString   *password;
@property(nonatomic, strong) NSString   *userName;
@property(nonatomic, strong) NSString   *accessToken;
@property(nonatomic, strong) NSString     *deviceToken;


@property(nonatomic, assign) BOOL       secureSignin;
@property(nonatomic, assign) BOOL       receiveMessage;
@property(nonatomic, strong) NSString   *language;
@property(nonatomic, assign) BOOL       changelanguage;

- (void)removeInformation;
- (void)setInformation:(NSString*)mobile password:(NSString*)password user:(NSString*)userName token:(NSString*)accessToken;
- (void)saveSettings;
- (void)saveSettingUp;
- (void)removeLang;
- (void)setLang;
- (void)saveDeviceToken:(NSString*)deviceToken;
@end