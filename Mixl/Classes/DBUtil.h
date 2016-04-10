//
//  Constants.h
//  Mixl
//
//  Created by admin on 4/8/16.
//  Copyright © 2016 Brani. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_DidReceiveMessage @"APP_DidReceiveMessage"
#define APP_UpdateUnreadMessage @"APP_UpdateUnreadMessage"
#define APP_ReloadIssueMessage @"APP_ReloadIssueMessage"

@interface DBUtil : NSObject

+ (DBUtil*)sharedInstance;

// Apis for saved 
- (NSArray*) loadDoctors;
- (void) addDoctor:(NSMutableDictionary*)doctorDict;
- (void) removeDoctor:(NSDictionary*)delDoctor;
- (void) saveDoctors:(NSArray*)doctors;

- (NSArray*) loadPosts;
- (void) addPost:(NSMutableDictionary*)postDict;
- (void) removePost:(NSDictionary*)delPost;
- (void) savePosts:(NSArray*)posts;

- (NSArray*) loadFilters;
- (BOOL) addFilter:(NSDictionary*)filterDict;
- (void) saveFilters:(NSArray*)filters;

- (NSMutableArray*) loadIssues;
- (void) addIssue:(NSMutableDictionary*)issueDict;
- (void) removeIssue:(NSDictionary*)delIssue;
- (void) saveIssues:(NSArray*)issues;

- (NSArray*)loadUnreadIssues;
- (void)removeUnreadIssue:(NSNumber*)issueId;
- (void)addUnreadIssue:(NSNumber*)issueId;
- (void)saveUnreadIssues:(NSArray*)issues;
- (void)didReceiveMessage:(NSDictionary*)messageInfo;
- (void)checkUnreadMdessage;

- (void)loadDB;

@end
