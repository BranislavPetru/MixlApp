//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "RedmineAPI.h"

@implementation BDCRedmineAPI

+ (BDCRedmineAPI *)sharedManager {
    static BDCRedmineAPI *sharedManager = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BDCRedmineAPI alloc] initWithBaseURL:[NSURL URLWithString: BDCRMApiBaseUrl]];
        sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sharedManager.requestSerializer setTimeoutInterval:30.0];
        sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return sharedManager;
}

- (void)RegistrationStep1:(NSString*)PhoneNumber
                onSuccess:(SuccessBlock)completionBlock
                onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"PhoneNumber":PhoneNumber}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiRegistration1];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)RegistrationStep2:(NSString*)CodeNumber
                  byTaken:(NSString*)VerifyToken
                onSuccess:(SuccessBlock)completionBlock
                onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"CodeNumber":CodeNumber, @"VerifyToken":VerifyToken}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiRegistration2];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];

}
- (void)RegistrationStep3:(NSString*)PhoneNumber
                   byName:(NSString*)UserName
               byPassword:(NSString*)Password
                onSuccess:(SuccessBlock)completionBlock
                onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"PhoneNumber":PhoneNumber, @"UserName":UserName, @"Password":Password}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiRegistration3];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)Auth:(NSString*)PhoneNumber
  byPassword:(NSString*)Password
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"PhoneNumber":PhoneNumber, @"Password":Password}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiAuth];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)Verification:(NSString*)Access_Token
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"AccessToken":Access_Token}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiVerification];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)Facebook:(NSString*)Access_Token
       onSuccess:(SuccessBlock)completionBlock
       onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"access_token":Access_Token}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiFaceBook];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];

}

- (void)weChat:(NSString*)code
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@?code=%@", BDCRMApiBaseUrl, BDCRMApiWeChat, [code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void)Forget:(NSString*)PhoneNumber
     onSuccess:(SuccessBlock)completionBlock
     onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"PhoneNumber":PhoneNumber}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiForget];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];

}

- (void)Logout:(NSString*)Access_Token
       onSuccess:(SuccessBlock)completionBlock
       onFailure:(FailureBlock)failureBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"access_token":Access_Token}];
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiLogout];
    [self DELETE:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)CreateDoctor:(NSMutableDictionary*)parameters
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiCreateDoctor];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)get_Doctor:(NSString*)Access_Token
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@?AccessToken=%@", BDCRMApiBaseUrl, BDCRMApiGetDoctor, [Access_Token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void)deleteDoctor:(NSMutableDictionary*)parameters
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApideleteDoctor];
    [self DELETE:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)CreatePost:(NSMutableDictionary*)parameters
        onSuccess:(SuccessBlock)completionBlock
        onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiCreatePost];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];

}

- (void)get_Post:(NSString*)Access_Token
      onSuccess:(SuccessBlock)completionBlock
      onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@?AccessToken=%@", BDCRMApiBaseUrl, BDCRMApiGetPost, [Access_Token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void)deletePost:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApideletePost];
    [self DELETE:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getFilter:(NSString*)Access_Token
        onSuccess:(SuccessBlock)completionBlock
        onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@?AccessToken=%@", BDCRMApiBaseUrl, BDCRMApiGetFilterList, [Access_Token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void)saveFilter:(NSMutableDictionary*)parameters
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiSaveFilter];
    [self PUT:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)getSetting:(NSString*)Access_Token
        onSuccess:(SuccessBlock)completionBlock
        onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@?AccessToken=%@", BDCRMApiBaseUrl, BDCRMApiGetSetting, [Access_Token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void)saveSetting:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiSaveSetting];
    [self PUT:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)changePassword:(NSMutableDictionary*)parameters
          onSuccess:(SuccessBlock)completionBlock
          onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiChangePassword];
    [self PUT:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)loadIssues:(NSString*)Access_Token
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@?AccessToken=%@", BDCRMApiBaseUrl, BDCRMApiLoadAllIssue, [Access_Token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)createIssues:(NSMutableDictionary*)parameters
          onSuccess:(SuccessBlock)completionBlock
          onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiCreatIssue];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)deleteIssue:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApideleteIssue];
    [self DELETE:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)loadMessage:(NSMutableDictionary*)parameters
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiReceiveMessage];
    [self GET:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)sendMessage:(NSMutableDictionary*)parameters
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiSendMessage];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)defMessage:(NSString*)Access_Token
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@?AccessToken=%@", BDCRMApiBaseUrl, BDCRMApidefMessage, [Access_Token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void)setOneRead:(NSMutableDictionary*)parameters
          onSuccess:(SuccessBlock)completionBlock
          onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApisetOneReadMessage];
    [self PUT:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)setRead:(NSMutableDictionary*)parameters
      onSuccess:(SuccessBlock)completionBlock
      onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApisetReadMessage];
    [self PUT:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}
- (void)findFAQ:(NSMutableDictionary*)parameters
          onSuccess:(SuccessBlock)completionBlock
          onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiFindFAQ];
    [self GET:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void)registerTokenDevice:(NSMutableDictionary*)parameters
           onSuccess:(SuccessBlock)completionBlock
           onFailure:(FailureBlock)failureBlock{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCRMApiBaseUrl, BDCRMApiRegistTokenDevice];
    [self POST:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
    
}

- (void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        [SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"POST url : %@", url);
    NSLog(@"POST param : %@", parameters);
    
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
        NSLog(@"POST success %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"POST error %@", error);
        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void)GET:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        [SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"GET url : %@", url);
    NSLog(@"GET param : %@", parameters);
    
    [self GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"GET success : %@", responseObject);
        completionBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSLog(@"GET error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void)PUT:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        [SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"PUT url : %@", url);
    NSLog(@"PUT param : %@", parameters);
    
    [self PUT:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"PUT success : %@", responseObject);
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSLog(@"PUT error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void)DELETE:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        [SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"DELETE url : %@", url);
    NSLog(@"DELETE param : %@", parameters);
    
    [self DELETE:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
        NSLog(@"DELETE success : %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"DELETE error : %@", error);
        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}




@end
