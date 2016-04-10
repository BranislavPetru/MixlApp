
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>





@interface BDCGlobal : NSObject

+(BDCGlobal*) sharedInstance;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSMutableArray *aryCountries;
@property (nonatomic, retain) NSMutableArray *aryCountryCode;

#pragma mark - Text utility
#define NSLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
#define IS_VALID_STR(x) (x != nil && [x isKindOfClass:[NSString class]] && x.length > 0)
+ (BOOL) isValidEmail:(NSString*)email;

#pragma mark - UI utility

#define UIColorFromRGBA(rgbValue, alphaValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 \
alpha:alphaValue])
#define UIColorFromRGB(rgbValue) (UIColorFromRGBA((rgbValue), 1.0))

#define CHINA_COUNTRY_CODE @"86"
#define HELP_PHONE_NUMBER @"4000215190"

#pragma mark - Screen Size
+ (int)  screenWidth;
+ (int)  screenHeight;
+ (CGSize)screenSize;

#pragma mark - View Effect
+ (void) setBorderEffect:(UIView *)view;
+ (void) setBorderEffect:(UIView *)view borderColor:(UIColor *)borderColor;
+ (void) setBorderEffect:(UIView *)view backColor:(UIColor*) backColor borderColor:(UIColor *)borderColor;

#pragma mark - Dynamic Font
#define FONTSIZE_SMALL  12
#define FONTSIZE_MEDIUM 15
#define FONTSIZE_LARGE  17
+ (UIFont*) smallFont:(NSString*) fontName;
+ (UIFont*) mediumFont:(NSString*) fontName;
+ (UIFont*) largeFont:(NSString*) fontName;

#pragma mark - ReadWrite
+ (NSArray*) readArrayFromPlist:(NSString*)filename;
+ (NSArray*) loadArrayFile:(NSString*) fileName;
+ (NSString*)       saveArrayFile:(NSArray *)data withName:(NSString*)name;

#pragma mark - Animation
- (void) moveFromCenter:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) moveFromLeftOutSide:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) moveFromRightOutSide:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) moveToCurrent:(UIView*)view from:(CGRect)frame withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;
- (void) hideAndShow:(UIView*)view withDuration:(NSTimeInterval)duration afterDelay:(NSTimeInterval)delay;

#pragma mark - NSUserDefault
#define USER_EMAIL      @"USER_EMAIL"
#define USER_PASSWORD   @"USER_PASSWORD"
- (void) saveAccountInfo:(NSString*)email password:(NSString*)password;
- (void) clearAccountInfo;
- (NSDictionary*) loadAccountInfo;

#pragma mark - DateString
+ (NSString*)stringFromDate:(NSDate*) date withFormat:(NSString*)format;
+ (NSString*)stringEncode:(NSString*)inputString;

#pragma mark - Phone Call
+ (void) callPhone:(NSString*)number country:(NSString*)code;
+ (NSString *)hexadecimalString:(NSData*) data;
@end
