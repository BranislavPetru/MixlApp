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

#define BDCApiBaseUrl           @"http://wwwtest.bestdoctors.club/wp-json"
#define BDCApiCategory          @"taxonomies/departments_category/terms?filter[parent]="
#define BDCApiLanguages         @"getlanguages"
#define BDCApiLicenses          @"getlicenses"
#define BDCApiDoctorList        @"posts?type[]=doctors"
#define BDCApiDoctorSearch      @"search?"
#define BDCApiDoctorDetail      @"posts"
#define BDCApiPost              @"updates"

typedef void (^SuccessBlock)(id json);
typedef void (^FailureBlock)(NSInteger statusCode, id json);

@interface BDCAPI : AFHTTPSessionManager;

+ (BDCAPI *)sharedManager;

- (void)getCategories:(NSString*)categoryId
            onSuccess:(SuccessBlock)completionBlock
            onFailure:(FailureBlock)failureBlock;

- (void)getSpokenLanguages:(SuccessBlock)completionBlock
                     onFailure:(FailureBlock)failureBlock;

- (void)getMDLicenses:(SuccessBlock)completionBlock
                     onFailure:(FailureBlock)failureBlock;

- (void)getAllDoctors:(SuccessBlock)completionBlock
            onFailure:(FailureBlock)failureBlock;

- (void)getDoctors:(NSString*)searchKey
          byFilter:(NSDictionary*)filter
         onSuccess:(SuccessBlock)completionBlock
         onFailure:(FailureBlock)failureBlock;

- (void)getDoctorDetail:(NSString*)doctorId
              onSuccess:(SuccessBlock)completionBlock
              onFailure:(FailureBlock)failureBlock;

- (void)getPosts:(int)page
       onSuccess:(SuccessBlock)completionBlock
       onFailure:(FailureBlock)failureBlock;

- (void)getPostDetail:(NSString*)postId
            onSuccess:(SuccessBlock)completionBlock
            onFailure:(FailureBlock)failureBlock;

@end
