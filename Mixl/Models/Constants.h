//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#ifndef Spark_Constants_h
#define Spark_Constants_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// NSUserDefaults Keys
#define kUDAppLastStartTime         @"appLastStartTime"
#define kUDUserID                   @"userid"
#define kUDFacebookID               @"facebookId"
#define kUDEmail                    @"email"
#define kUDPhone                    @"phone"
#define kUDFirstName                @"fname"
#define kUDLastName                 @"lname"
#define kUDProfileImage             @"profile_image"
#define kUDAuthToken                @"auth_token"
#define kUDPushDeviceToken          @"pushDeviceToken"
#define kUDPaymentMethod            @"paymentMethod"

// NSNotification Names
#define     kPNPublishMessageNotification           @"PNPublishMessageNotification"
#define     kPNDidReceiveMessageNotification        @"PNDidReceiveMessageNotification"

// NSNotification UserInfo Keys
#define     kNUChatMessage                          @"chatMessage"
#define     kNUTimeToken                            @"timeToken"
#define     kNUSender                               @"sender"

// PN Message Keys
#define     kPMMessage                              @"message"
#define     kPMSender                               @"sender"


#define     SIDEBAR_TITLE_TAG                       @"title"
#define     SIDEBAR_ICON_TAG                        @"icon"

#define     SIDEBAR_PROFILE_TITLE                   @"Profile"
#define     SIDEBAR_CHAT_TITLE                      @"Chat"
#define     SIDEBAR_PEOPLENEARBY_TITLE              @"People Nearby"
#define     SIDEBAR_FRIENDSNEARBY_TITLE             @"Friends Nearby"
#define     SIDEBAR_OFFERS_TITLE                    @"Offers"
#define     SIDEBAR_FRIENDREQUESTS_TITLE            @"Friend Request"
#define     SIDEBAR_SETTINGS_TITLE                  @"Settings"
#define     SIDEBAR_LOGOUT_TITLE                    @"Log out"

#define     SIDEBAR_PROFILE_ICON                    @"icon_userprofile"
#define     SIDEBAR_CHAT_ICON                       @"icon_chat"
#define     SIDEBAR_PEOPLENEARBY_ICON               @"icon_peoplenearby"
#define     SIDEBAR_FRIENDSNEARBY_ICON              @"icon_groupnearby"
#define     SIDEBAR_OFFERS_ICON                     @"icon_offer"
#define     SIDEBAR_FRIENDREQUESTS_ICON             @"icon_peoplenearby"
#define     SIDEBAR_SETTINGS_ICON                   @"icon_setting"
#define     SIDEBAR_LOGOUT_ICON                     @"icon_logout"


#define     CROPIMAGE_SIZE_WIDTH                    300
#define     CROPIMAGE_SIZE_HEIGHT                   300

typedef enum{
    SIDEBAR_PROFILE_ITEM = 0,
    SIDEBAR_CHAT_ITEM,
    SIDEBAR_PEOPLENEARBY_ITEM,
    SIDEBAR_FRIENDSNEARBY_ITEM,
    SIDEBAR_OFFERS_ITEM,
    SIDEBAR_FRIENDREQUESTS_ITEM,
    SIDEBAR_SETTINGS_ITEM,
    SIDEBAR_LOGOUT_ITEM
}SIDEBAR_ITEMS;

#define     SIDEBAR_WIDTH_RATE                      0.6f

//webservice post param keywords
#define     USERINFO_HASH_KEY                       @"hashed_shared_key"
#define     USERINFO_FIRSTNAME_KEY                  @"first_name"
#define     USERINFO_LASTNAME_KEY                   @"last_name"
#define     USERINFO_EMAIL_KEY                      @"email"
#define     USERINFO_PASSWORD_KEY                   @"password"
#define     USERINFO_ZIPCODE_KEY                    @"zip_code"
#define     USERINFO_DEVICETOKEN_KEY                @"device_token"
#define     USERINFO_DEVICEMODEL_KEY                @"device_model"
#define     USERINFO_DEVICEUID_KEY                  @"device_uid"
#define     USERINFO_USERNAME_KEY                   @"username"
#define     USERINFO_AVATAR_KEY                     @"avatar"
#define     USERINFO_HASHEDPASSWORK_KEY             @"hashed_password"
#define     USERINFO_USER_KEY                       @"user"
#define     USERINFO_SUBSCRIBER_KEY                 @"subscriber"

//Garage Types
#define     GARAGE_TYPES    @[@"Driveway",@"Private",@"Parking Lot",@"Public"]

//Neigborhood
#define     NEIGBORHOODS    @[@"Pacific Heights",@"Mission District",@"Nob Hill",@"Russion Hill",@"SOMA",@"Financial District",@"Castro",@"USF",@"Haight Ashbury",@"Lower Haight",@"Noe Valley",@"North Beach"]

#endif
