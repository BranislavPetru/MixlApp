//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "BDCAPI.h"

@implementation BDCAPI

+ (BDCAPI *)sharedManager {
    static BDCAPI *sharedManager = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        sharedManager = [[BDCAPI alloc] initWithBaseURL:[NSURL URLWithString: BDCApiBaseUrl]];
        sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sharedManager.requestSerializer setTimeoutInterval:30.0];
        sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return sharedManager;
}

- (void)getCategories:(NSString*)categoryId
            onSuccess:(SuccessBlock)completionBlock
            onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@", BDCApiCategory, categoryId];
    [self GET:url onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getSpokenLanguages:(SuccessBlock)completionBlock
                 onFailure:(FailureBlock)failureBlock
{
    [self GET:BDCApiLicenses onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getMDLicenses:(SuccessBlock)completionBlock
            onFailure:(FailureBlock)failureBlock
{
    [self GET:BDCApiLanguages onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getAllDoctors:(SuccessBlock)completionBlock
            onFailure:(FailureBlock)failureBlock
{
    [self GET:BDCApiDoctorList onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getDoctors:(NSString*)searchKey
          byFilter:(NSDictionary*)filter
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@filter[s]=%@", BDCApiDoctorSearch, searchKey];
    if (filter != nil) {
        url = [NSString stringWithFormat:@"%@&filter[md]=%@&filter[lang]=%@&filter[type]=%@", url,
               [filter objectForKey:@"License"],
               [filter objectForKey:@"Language"],
               [filter objectForKey:@"Interest"]];
    }
    [self GET:url onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getDoctorDetail:(NSString*)doctorId
              onSuccess:(SuccessBlock)completionBlock
              onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", BDCApiDoctorDetail, doctorId];
    [self GET:url onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getPosts:(int)page
       onSuccess:(SuccessBlock)completionBlock
       onFailure:(FailureBlock)failureBlock
{
    [self GET:BDCApiPost onSuccess:completionBlock onFailure:failureBlock];
}

- (void)getPostDetail:(NSString*)postId
            onSuccess:(SuccessBlock)completionBlock
            onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", BDCApiPost, postId];
    [self GET:url onSuccess:completionBlock onFailure:failureBlock];
}


- (void)GET:(NSString *)url
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
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"%@", error);
        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

@end
