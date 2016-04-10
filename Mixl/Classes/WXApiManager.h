//
//  WXApiManager.h
//  wechatauthdemo
//
//  Created by Chuang Chen on 6/25/15.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiObject.h"

@protocol WXAuthDelegate <NSObject>

@optional
    - (void)wxAuthSucceed:(NSString*)code;
    - (void)wxAuthDenied;
    - (void)wxAuthCancel;
@end

@interface WXApiManager : NSObject <WXApiDelegate>

@property (nonatomic, assign) id<WXAuthDelegate, NSObject> delegate;
    + (instancetype)sharedManager;
    - (void)sendAuthRequestWithController:(UIViewController*)viewController delegate:(id<WXAuthDelegate>)delegate;
@end
