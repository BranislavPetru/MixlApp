//
//  Utils.m
//  Spark
//
//  Created by Kuznetsov Andrey on 01/08/15.
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (BOOL)validateEmail: (NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validateString:(NSString*)entry {
    entry = [entry stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (entry.length > 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (UIImage *)blankAvatarImage {
    static UIImage *blankAvatarImage = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        blankAvatarImage = [UIImage imageNamed:@"avatar_placeholder.png"];
    });
    return blankAvatarImage;
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (NSArray*) readArrayFromPlist:(NSString*)filename
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    NSArray* array = [[NSArray alloc] initWithContentsOfFile:path];
    return array;
}
+ (NSArray*)loadArrayFile:(NSString*) fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSArray* data = [NSArray arrayWithContentsOfFile:path];
    return data;
}

+ (NSString*)saveArrayFile:(NSArray *)data withName:(NSString*)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedPath = [documentsDirectory stringByAppendingPathComponent:name];
    
    BOOL success = [data writeToFile:savedPath atomically:YES];
    NSLog(@"File save result : %d", success);
    return savedPath;
}

+ (NSString*)dateStringFrom:(NSDate*)date {
    if ([[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date] day] ==
        [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate date]] day]) {
        return @"Today";
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd"];
        return [formatter stringFromDate:date];
    }
}

+ (NSString*)timeStringFrom:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    return [formatter stringFromDate:date];
}

+ (NSString*)dateTimeStringFrom:(NSDate*)date {
    return [NSString stringWithFormat:@"%@, %@", [Utils dateStringFrom:date], [Utils timeStringFrom:date]];
}

@end
