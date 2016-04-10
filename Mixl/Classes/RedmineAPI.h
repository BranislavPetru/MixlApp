//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "Reachability.h"
#import "SHAlertHelper.h"

#define BDCRMApiBaseUrl                 @"http://redmine-api.desoft.su"
#define BDCRMApiRegistration1           @"/mobile_api/registration"
#define BDCRMApiRegistration2           @"/mobile_api/registration/step2"
#define BDCRMApiRegistration3           @"/mobile_api/registration/step3"
#define BDCRMApiAuth                    @"/mobile_api/auth"
#define BDCRMApiVerification            @"/mobile_api/auth/verefication_access_token"
#define BDCRMApiFaceBook                @"/mobile_api/auth/facebook"
#define BDCRMApiWeChat                  @"/mobile_api/auth/wechat"
#define BDCRMApiForget                  @"/mobile_api/forget"
#define BDCRMApiLogout                  @"/mobile_api/logout"
#define BDCRMApiCreatePost              @"/mobile_api/bookmark/posts/new"
#define BDCRMApiCreateDoctor            @"/mobile_api/bookmark/doctors/new"
#define BDCRMApiGetPost                 @"/mobile_api/bookmark/posts"
#define BDCRMApiGetDoctor               @"/mobile_api/bookmark/doctors"
#define BDCRMApideletePost              @"/mobile_api/bookmark/posts/destroy"
#define BDCRMApideleteDoctor            @"/mobile_api/bookmark/doctors/destroy"
#define BDCRMApiGetFilterList           @"/mobile_api/filters"
#define BDCRMApiSaveFilter              @"/mobile_api/filters/update"
#define BDCRMApiGetSetting              @"/mobile_api/setting"
#define BDCRMApiSaveSetting             @"/mobile_api/setting/update"
#define BDCRMApiChangePassword          @"/mobile_api/setting/change_password"
#define BDCRMApiCreatIssue              @"/mobile_api/issues/new"
#define BDCRMApiLoadAllIssue            @"/mobile_api/issues"
#define BDCRMApideleteIssue             @"/mobile_api/issues/delete"
#define BDCRMApiSendMessage             @"/mobile_api/issues/messages/send"
#define BDCRMApiReceiveMessage          @"/mobile_api/issues/messages"
#define BDCRMApidefMessage              @"/mobile_api/issues/new_messages"
#define BDCRMApisetOneReadMessage       @"/mobile_api/issues/messages/set_one_read"
#define BDCRMApisetReadMessage          @"/mobile_api/issues/messages/set_read"
#define BDCRMApiFindFAQ                 @"/mobile_api/faq"
#define BDCRMApiRegistTokenDevice       @"/mobile_api/services/registration_token_device"

typedef void (^SuccessBlock)(id json);
typedef void (^FailureBlock)(NSInteger statusCode, id json);

@interface BDCRedmineAPI : AFHTTPSessionManager;

+ (BDCRedmineAPI *)sharedManager;

- (void)RegistrationStep1:(NSString*)PhoneNumber
                onSuccess:(SuccessBlock)completionBlock
                onFailure:(FailureBlock)failureBlock;               //Return--> ResponseResult=YES, ResponseContent:{ VerifyToken:{####..}}

- (void)RegistrationStep2:(NSString*)CodeNumber                     //CodeNumber=1111(default)
                  byTaken:(NSString*)VerifyToken
                onSuccess:(SuccessBlock)completionBlock
                onFailure:(FailureBlock)failureBlock;               //Return--> ResponseResult=YES, ResponseContent=(PhoneNumber)

- (void)RegistrationStep3:(NSString*)PhoneNumber
                   byName:(NSString*)UserName
               byPassword:(NSString*)Password
                onSuccess:(SuccessBlock)completionBlock
                onFailure:(FailureBlock)failureBlock;               //Return--> ResponseResult=YES, ResponseContent:{ AccessToKen:{####..}}

- (void)Auth:(NSString*)PhoneNumber
  byPassword:(NSString*)Password
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock;                           

- (void)Verification:(NSString*)Access_Token
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock;

- (void)Facebook:(NSString*)Access_Token
       onSuccess:(SuccessBlock)completionBlock
       onFailure:(FailureBlock)failureBlock;

- (void)weChat:(NSString*)code
     onSuccess:(SuccessBlock)completionBlock
     onFailure:(FailureBlock)failureBlock;

- (void)Forget:(NSString*)PhoneNumber
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock;

- (void)Logout:(NSString*)Access_Token
     onSuccess:(SuccessBlock)completionBlock
     onFailure:(FailureBlock)failureBlock;

- (void)CreatePost:(NSMutableDictionary*)parameters
                onSuccess:(SuccessBlock)completionBlock
                onFailure:(FailureBlock)failureBlock;

- (void)CreateDoctor:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)get_Post:(NSString*)Access_Token
              onSuccess:(SuccessBlock)completionBlock
              onFailure:(FailureBlock)failureBlock;

- (void)get_Doctor:(NSString*)Access_Token
              onSuccess:(SuccessBlock)completionBlock
              onFailure:(FailureBlock)failureBlock;

- (void)deletePost:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)deleteDoctor:(NSMutableDictionary*)parameters
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock;

- (void)getFilter:(NSString*)Access_Token
        onSuccess:(SuccessBlock)completionBlock
        onFailure:(FailureBlock)failureBlock;

- (void)saveFilter:(NSMutableDictionary*)parameters
        onSuccess:(SuccessBlock)completionBlock
        onFailure:(FailureBlock)failureBlock;

- (void)getSetting:(NSString*)Access_Token
        onSuccess:(SuccessBlock)completionBlock
        onFailure:(FailureBlock)failureBlock;

- (void)saveSetting:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)changePassword:(NSMutableDictionary*)parameters
          onSuccess:(SuccessBlock)completionBlock
          onFailure:(FailureBlock)failureBlock;

- (void)loadIssues:(NSString*)Access_Token
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)createIssues:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)deleteIssue:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)loadMessage:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)sendMessage:(NSMutableDictionary*)parameters
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock;

- (void)defMessage:(NSString*)Access_Token
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)setOneRead:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)setRead:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)findFAQ:(NSMutableDictionary*)parameters
          onSuccess:(SuccessBlock)completionBlock
          onFailure:(FailureBlock)failureBlock;

- (void)registerTokenDevice:(NSMutableDictionary*)parameters
      onSuccess:(SuccessBlock)completionBlock
      onFailure:(FailureBlock)failureBlock;

@end