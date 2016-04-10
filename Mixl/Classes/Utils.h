//
//  Utils.h
//  Spark
//
//  Created by Kuznetsov Andrey on 01/08/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Utils : NSObject

+ (BOOL)validateEmail: (NSString *)candidate;
+ (BOOL)validateString:(NSString*)entry;

+ (UIImage *)blankAvatarImage;

+ (AppDelegate *)appDelegate;

+ (NSArray*)readArrayFromPlist:(NSString*)filename;
+ (NSArray*)loadArrayFile:(NSString*) fileName;
+ (NSString*)saveArrayFile:(NSArray *)data withName:(NSString*)name;

+ (NSString*)dateStringFrom:(NSDate*)date;

+ (NSString*)timeStringFrom:(NSDate*)date;

+ (NSString*)dateTimeStringFrom:(NSDate*)date;

@end
