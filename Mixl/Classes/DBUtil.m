//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import "DBUtil.h"
#import "BDCGlobal.h"
#import "RedmineAPI.h"
#import "UserInformation.h"
#import "BDCGlobal.h"

@implementation DBUtil

+(DBUtil*)sharedInstance {
    
    static DBUtil *sharedObject = nil;
    if (sharedObject == nil)    {
        sharedObject = [[self alloc] init];
    }
    return sharedObject;
}

- (void)loadDB
{
    //loading Doctor---
    [[BDCRedmineAPI sharedManager] get_Doctor:[UserInformation sharedInstance].accessToken onSuccess:^(id json) {
        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"])
          if([json objectForKey:@"ResponseContent"] != [NSNull null]){
                [self saveDoctors:[[NSArray alloc] initWithArray:[json objectForKey:@"ResponseContent"]]];
           }
    } onFailure:^(NSInteger statusCode, id json) {
        
    }];
    
    //loading Post---
    [[BDCRedmineAPI sharedManager] get_Post:[UserInformation sharedInstance].accessToken onSuccess:^(id json) {
        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"])
           if([json objectForKey:@"ResponseContent"] != [NSNull null]){
               [self savePosts:[[NSArray alloc] initWithArray:[json objectForKey:@"ResponseContent"]]];
           }
    } onFailure:^(NSInteger statusCode, id json) {
        
    }];
    
    //loading Filter---
    [[BDCRedmineAPI sharedManager] getFilter:[UserInformation sharedInstance].accessToken onSuccess:^(id json) {
        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"]){
           if([[json objectForKey:@"ResponseContent"] objectForKey:@"FilterList"] != [NSNull null]){
               [self saveFilters:[[NSArray alloc] initWithArray:[[json objectForKey:@"ResponseContent"] objectForKey:@"FilterList"]]];
           }
        }
        
    } onFailure:^(NSInteger statusCode, id json) {
        
    }];

    //loading Issue---
    [[BDCRedmineAPI sharedManager] loadIssues:[UserInformation sharedInstance].accessToken onSuccess:^(id json) {
        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"])
        {   NSMutableArray* issuesArray = [[NSMutableArray alloc] init];
            if([[json objectForKey:@"ResponseContent"] objectForKey:@"IssueList"] != [NSNull null]){
                NSArray* issues =[[NSArray alloc] initWithArray:[[json objectForKey:@"ResponseContent"] objectForKey:@"IssueList"]];
                for(NSDictionary* issue in issues)
                {
                    NSMutableDictionary *newissue = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[issue objectForKey:@"IssueID"], @"IssueID",
                                                     [BDCGlobal stringEncode:[issue objectForKey:@"Title"]], @"Title",
                                               [BDCGlobal stringEncode:[issue objectForKey:@"Description"]], @"Description",
                                                 [BDCGlobal stringEncode:[issue objectForKey:@"CreatedOn"]], @"CreatedOn", nil];
                    [issuesArray addObject:newissue];
                }
                issuesArray = [[NSMutableArray alloc] initWithArray:[[issuesArray reverseObjectEnumerator] allObjects]];
                [self saveIssues:issuesArray];
                
                // Check Unread Message
                [self checkUnreadMdessage];
            }
            else
            {
                NSMutableDictionary* HelpCenter = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [UserInformation sharedInstance].accessToken, @"AccessToken",
                                                   NSLocalizedString(@"Help Center", nil), @"Title",
                                                             [BDCGlobal stringEncode:@""], @"Description", nil];
                
                [[BDCRedmineAPI sharedManager] createIssues:HelpCenter onSuccess:^(id json) {
                    if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"]){
                       if([[json objectForKey:@"ResponseContent"] objectForKey:@"IssueInfo"] != [NSNull null]){
                            NSMutableDictionary *newissue = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[[json objectForKey:@"ResponseContent"] objectForKey:@"IssueInfo"]
                                                                                                                                                        objectForKey:@"IssueID"], @"IssueID",
                                                             [BDCGlobal stringEncode:[[[json objectForKey:@"ResponseContent"] objectForKey:@"IssueInfo"] objectForKey:@"Title"]], @"Title",
                                                             [BDCGlobal stringEncode:[[[json objectForKey:@"ResponseContent"] objectForKey:@"IssueInfo"] objectForKey:@"Description"]], @"Description",
                                                             [BDCGlobal stringEncode:[[[json objectForKey:@"ResponseContent"] objectForKey:@"IssueInfo"] objectForKey:@"CreatedOn"]], @"CreatedOn", nil];
                            [issuesArray addObject:newissue];
                            [self saveIssues:issuesArray];
                        }
                    }
                    else
                    {   UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                                        message:NSLocalizedString(@"AccessToken invalid", nil)
                                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        return;
                    }
                } onFailure:^(NSInteger statusCode, id json) {
                    
                }];

            }
        }
    } onFailure:^(NSInteger statusCode, id json) {
        
    }];

}


//------------------Doctors----------------
- (NSArray*) loadDoctors {
    return [BDCGlobal loadArrayFile:@"savedDoctors"];
}

- (void) addDoctor:(NSMutableDictionary*)doctorDict {
    NSMutableArray* savedDoctors = [[NSMutableArray alloc] initWithArray:[self loadDoctors]];
    [savedDoctors addObject:doctorDict];
    [self saveDoctors:savedDoctors];
}

- (void) removeDoctor:(NSDictionary*)delDoctor {
    NSMutableArray* updatedDoctors = [[NSMutableArray alloc] initWithArray:[self loadDoctors]];
    [updatedDoctors removeObject:delDoctor];
    [self saveDoctors:updatedDoctors];
}

- (void)saveDoctors:(NSArray*)doctors {
    [BDCGlobal saveArrayFile:doctors withName:@"savedDoctors"];
}

//------------------Posts----------------
- (NSArray*) loadPosts {
    return [BDCGlobal loadArrayFile:@"savedPosts"];
}

- (void) addPost:(NSMutableDictionary*)postDict {
    NSMutableArray* savedPosts = [[NSMutableArray alloc] initWithArray:[self loadPosts]];
    [savedPosts addObject:postDict];
    [self savePosts:savedPosts];
}

- (void) removePost:(NSDictionary*)delPost {
    NSMutableArray* updatedPosts = [[NSMutableArray alloc] initWithArray:[self loadPosts]];
    [updatedPosts removeObject:delPost];
    [self savePosts:updatedPosts];
}

- (void)savePosts:(NSArray*)posts {
    [BDCGlobal saveArrayFile:posts withName:@"savedPosts"];
}

//------------------Filters----------------
- (NSArray*) loadFilters {
    return [BDCGlobal loadArrayFile:@"savedFilters"];
}

- (BOOL) addFilter:(NSDictionary*)filterDict {
    NSMutableDictionary* newFilter = [[NSMutableDictionary alloc] initWithDictionary:filterDict];
    NSMutableArray* savedFilters = [[NSMutableArray alloc] initWithArray:[self loadFilters]];
    for (NSDictionary*filter in savedFilters) {
        if([[newFilter objectForKey:@"FilterName"] isEqualToString:[filter objectForKey:@"FilterName"]]) {
            return NO;
        }
    }
    [savedFilters addObject:newFilter];
    [self saveFilters:savedFilters];
    return YES;
}

- (void)saveFilters:(NSArray*)filters {
    [BDCGlobal saveArrayFile:filters withName:@"savedFilters"];
}

//------------------Issues----------------
- (NSArray*)loadIssues {
    return [BDCGlobal loadArrayFile:@"savedIssues"];
}

- (void) addIssue:(NSMutableDictionary*)issueDict {
    NSMutableArray* savedIssues = [[NSMutableArray alloc] initWithArray:[self loadIssues]];
    [savedIssues addObject:issueDict];
    [self saveIssues:savedIssues];
}

- (void) removeIssue:(NSDictionary*)delIssue {
    NSMutableArray* updatedIssue = [[NSMutableArray alloc] initWithArray:[self loadIssues]];
    [updatedIssue removeObject:delIssue];
    [self saveIssues:updatedIssue];
}

- (void)saveIssues:(NSArray*)issues {
    [BDCGlobal saveArrayFile:issues withName:@"savedIssues"];
}

//------------------Unread Issues----------------
- (NSArray*)loadUnreadIssues {
    return [BDCGlobal loadArrayFile:@"unreadIssues"];
}

- (void)removeUnreadIssue:(NSNumber*)issueId {
    NSMutableArray* updatedIssue = [[NSMutableArray alloc] initWithArray:[self loadUnreadIssues]];
    [updatedIssue removeObject:issueId];
    [self saveUnreadIssues:updatedIssue];
    [self updateUnreadNotify];
}

- (void)addUnreadIssue:(NSNumber*)issueId {
    NSMutableArray* updatedIssue = [[NSMutableArray alloc] initWithArray:[self loadUnreadIssues]];
    [updatedIssue addObject:issueId];
    [self saveUnreadIssues:updatedIssue];
    [self updateUnreadNotify];
}

- (void)saveUnreadIssues:(NSArray*)issues {
    [BDCGlobal saveArrayFile:issues withName:@"unreadIssues"];
    [self updateUnreadNotify];
}

- (void)updateUnreadNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_UpdateUnreadMessage
                                                        object:self
                                                      userInfo:nil];
}

- (void)checkUnreadMdessage {
    [[BDCRedmineAPI sharedManager] defMessage:[UserInformation sharedInstance].accessToken
                                    onSuccess:^(id json) {
                                        if([[json objectForKey:@"ResponseResult"]  isEqual:@"YES"]){
                                            [self saveUnreadIssues:[[json objectForKey:@"ResponseContent"] objectForKey:@"UnreadIssues"]];
                                            [[NSNotificationCenter defaultCenter] postNotificationName:APP_ReloadIssueMessage
                                                                                                object:self
                                                                                              userInfo:nil];
                                        }
                                    } onFailure:nil];

}

- (void)didReceiveMessage:(NSDictionary*)messageInfo {
    [self addUnreadIssue:[messageInfo objectForKey:@"IssueID"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:APP_DidReceiveMessage
                                                        object:self
                                                      userInfo:messageInfo];
    
}
@end
