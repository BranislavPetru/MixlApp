//
//  WXApiManager.m
//  wechatauthdemo
//
//  Created by Chuang Chen on 6/25/15.
//  Copyright (c) 2015 Tencent. All rights reserved.
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - Life Cycle
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initInPrivate];
    });

    return instance;
}

- (instancetype)initInPrivate {
    self = [super init];
    if (self) {
        _delegate = nil;
    }
    return self;
}

- (instancetype)init {
    return nil;
}

- (instancetype)copy {
    return nil;
}

#pragma mark - Public Methods
- (void)sendAuthRequestWithController:(UIViewController*)viewController delegate:(id<WXAuthDelegate>)delegate {
        SendAuthReq* req = [[SendAuthReq alloc] init];

        req.scope = @"snsapi_userinfo";
        req.state = @"STATE";
        self.delegate = delegate;
        [WXApi sendAuthReq:req viewController:viewController delegate:self];
}

#pragma mark - WXApiDelegate
-(void)onReq:(BaseReq*)req {
}

-(void)onResp:(BaseResp*)resp {
    NSLog(@"get");
    if([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp* authResp = (SendAuthResp*)resp;
        switch (resp.errCode) {
            case WXSuccess:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthSucceed:)])
                    [self.delegate wxAuthSucceed:authResp.code];
                break;
            case WXErrCodeAuthDeny:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthDenied)])
                    [self.delegate wxAuthDenied];
                break;
            default:
                if (self.delegate && [self.delegate respondsToSelector:@selector(wxAuthCancel)])
                    [self.delegate wxAuthCancel];
                break;
        }
    }
}

@end
