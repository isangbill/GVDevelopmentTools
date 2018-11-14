//
//  NSString+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/20.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "NSString+GVExtension.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (GVExtension)
- (BOOL)gv_isValidEmail {
    if ([self gv_isEmpty]) {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)gv_isEmpty {
    return (((self) == nil) || ([(self) isEqual:[NSNull null]]) ||([(self)isEqualToString:@""]));
}

- (BOOL)gv_includesString:(NSString *)string {
    if (!string || string.length <= 0) {
        return NO;
    }
    
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:string];
    }
    
    return [self rangeOfString:string].location != NSNotFound;
}

- (NSString *)gv_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)gv_trimAllWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)gv_trimLineBreakCharacter {
    return [self stringByReplacingOccurrencesOfString:@"[\r\n]" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

+ (NSString *)gv_hexStringWithInteger:(NSInteger)integer {
    NSString *hexString = @"";
    NSInteger remainder = 0;
    for (NSInteger i = 0; i < 9; i++) {
        remainder = integer % 16;
        integer = integer / 16;
        NSString *letter = [self hexLetterStringWithInteger:remainder];
        hexString = [letter stringByAppendingString:hexString];
        if (integer == 0) {
            break;
        }
        
    }
    return hexString;
    
}

+ (NSString *)hexLetterStringWithInteger:(NSInteger)integer {
    NSAssert(integer < 16, @"要转换的数必须是16进制里的个位数，也即小于16，但你传给我是%@", @(integer));
    
    NSString *letter = nil;
    switch (integer) {
        case 10:
            letter = @"A";
            break;
        case 11:
            letter = @"B";
            break;
        case 12:
            letter = @"C";
            break;
        case 13:
            letter = @"D";
            break;
        case 14:
            letter = @"E";
            break;
        case 15:
            letter = @"F";
            break;
        default:
            letter = [[NSString alloc]initWithFormat:@"%@", @(integer)];
            break;
    }
    return letter;
}

/// base64 加密
- (NSString *)gv_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

/// base64 解密
- (NSString *)gv_base64DecodedString
{
    return [NSString _gv_stringWithBase64EncodedString:self];
}

+ (NSString *)_gv_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)gv_MD5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ]lowercaseString];
}

+ (NSString *)gv_stringFromTimestamp {
    return [NSString stringWithFormat:@"%ld", (long)round([[NSDate date] timeIntervalSince1970])];
}

+ (NSString *)gv_stringFromBool:(BOOL)flag {
    return flag ? @"YES" : @"NO";
}

- (CGSize)gv_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize textSize = CGSizeZero;
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0)
    
    if (![self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // below ios7
        textSize = [self sizeWithFont:font
                    constrainedToSize:size
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
        
#endif
        
    {
        //iOS 7
        //        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        //        paragraphStyle.lineSpacing = 0.0;//增加行高
        //        paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
        //        paragraphStyle.tailIndent = 0;//相当于右padding
        //        paragraphStyle.lineHeightMultiple = 0;//行间距是多少倍
        //        paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
        //        paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
        //        paragraphStyle.paragraphSpacing = 2;//段落后面的间距
        //        paragraphStyle.paragraphSpacingBefore = 2;
        
        CGRect frame = [self boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        textSize = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return textSize;
    
}


- (CGFloat)gv_widthWithFont:(UIFont *)font {
    return [self gv_boundingSizeWithFont:font constrainedToSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}].width;
}

- (CGFloat)gv_heightWithFont:(UIFont *)font width:(CGFloat)width {
    return [self gv_boundingSizeWithFont:font constrainedToSize:(CGSize){width, CGFLOAT_MAX}].height;
}

+ (NSString *)gv_randomStringWithLength:(NSUInteger)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [[NSMutableString alloc] initWithCapacity:length];
    
    for (int i = 0; i < length; i++){
        NSUInteger rand = arc4random_uniform((u_int32_t)letters.length);
        [randomString appendFormat:@"%C", [letters characterAtIndex:rand]];
    }
    
    return randomString.copy;
}

+ (NSString *)gv_randomStringWithRandomLengthBetween:(NSUInteger)from to:(NSUInteger)to {
    NSUInteger count = (int)from + arc4random() % (to - from + 1);
    return [self gv_randomStringWithLength:count];
}

- (NSString *)gv_pathWithDocumentDirectory {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self];
}

- (NSString *)gv_pathWithLibraryDirectory {
    return [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self];
}

- (NSString *)gv_pathWithCacheDirectory {
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self];
}

#pragma mark - time
#define IsDigit(v) (v >= '0' && v <= '9')
static time_t parseRfc3339ToTimeT(const char *string)
{
    int dy, dm, dd;
    int th, tm, ts;
    int oh, om, osign;
    char current;
    
    if (!string)
        return (time_t)0;
    
    // date
    if (sscanf(string, "%04d-%02d-%02d", &dy, &dm, &dd) == 3) {
        string += 10;
        
        if (*string++ != 'T')
            return (time_t)0;
        
        // time
        if (sscanf(string, "%02d:%02d:%02d", &th, &tm, &ts) == 3) {
            string += 8;
            
            current = *string;
            
            // optional: second fraction
            if (current == '.') {
                ++string;
                while(IsDigit(*string))
                    ++string;
                
                current = *string;
            }
            
            if (current == 'Z') {
                oh = om = 0;
                osign = 1;
            } else if (current == '-') {
                ++string;
                if (sscanf(string, "%02d:%02d", &oh, &om) != 2)
                    return (time_t)0;
                osign = -1;
            } else if (current == '+') {
                ++string;
                if (sscanf(string, "%02d:%02d", &oh, &om) != 2)
                    return (time_t)0;
                osign = 1;
            } else {
                return (time_t)0;
            }
            
            struct tm timeinfo;
            timeinfo.tm_wday = timeinfo.tm_yday = 0;
            timeinfo.tm_zone = NULL;
            timeinfo.tm_isdst = -1;
            
            timeinfo.tm_year = dy - 1900;
            timeinfo.tm_mon = dm - 1;
            timeinfo.tm_mday = dd;
            
            timeinfo.tm_hour = th;
            timeinfo.tm_min = tm;
            timeinfo.tm_sec = ts;
            
            // convert to utc
            return timegm(&timeinfo) - (((oh * 60 * 60) + (om * 60)) * osign);
        }
    }
    
    return (time_t)0;
}

static NSDate *parseRfc3339ToNSDate(NSString *rfc3339DateTimeString)
{
    time_t t = parseRfc3339ToTimeT([rfc3339DateTimeString cStringUsingEncoding:NSUTF8StringEncoding]);
    return [NSDate dateWithTimeIntervalSince1970:t];
}

/*
 * Returns a user-visible date time string that corresponds to the
 * specified RFC 3339 date time string. Note that this does not handle
 * all possible RFC 3339 date time strings, just one of the most common
 * styles.
 */
+ (NSDate *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString
{
    return parseRfc3339ToNSDate(rfc3339DateTimeString);
}

+ (NSString *)gv_elapsedTimeStringSinceDate:(NSString *)uploadDateString
{
    // early return if no post date string
    if (!uploadDateString)
    {
        return @"NO POST DATE";
    }
    
    NSDate *postDate = [self userVisibleDateTimeStringForRFC3339DateTimeString:uploadDateString];
    
    if (!postDate) {
        return @"DATE CONVERSION ERROR";
    }
    
    NSDate *currentDate         = [NSDate date];
    
    NSCalendar *calendar        = [NSCalendar currentCalendar];
    
    NSUInteger seconds = [[calendar components:NSCalendarUnitSecond fromDate:postDate toDate:currentDate options:0] second];
    NSUInteger minutes = [[calendar components:NSCalendarUnitMinute fromDate:postDate toDate:currentDate options:0] minute];
    NSUInteger hours   = [[calendar components:NSCalendarUnitHour   fromDate:postDate toDate:currentDate options:0] hour];
    NSUInteger days    = [[calendar components:NSCalendarUnitDay    fromDate:postDate toDate:currentDate options:0] day];
    
    NSString *elapsedTime;
    
    if (days > 7) {
        elapsedTime = [NSString stringWithFormat:@"%luw", (long)ceil(days/7.0)];
    } else if (days > 0) {
        elapsedTime = [NSString stringWithFormat:@"%lud", (long)days];
    } else if (hours > 0) {
        elapsedTime = [NSString stringWithFormat:@"%luh", (long)hours];
    } else if (minutes > 0) {
        elapsedTime = [NSString stringWithFormat:@"%lum", (long)minutes];
    } else if (seconds > 0) {
        elapsedTime = [NSString stringWithFormat:@"%lus", (long)seconds];
    } else if (seconds == 0) {
        elapsedTime = @"1s";
    } else {
        elapsedTime = @"ERROR";
    }
    
    return elapsedTime;
}

@end
