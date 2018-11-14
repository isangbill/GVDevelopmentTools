//
//  GVDevHelper.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/26.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVDevHelper.h"
#import "GVLog.h"
#if __has_include(<SSKeychain.h>)
#import "SSKeychain.h"
#endif

@implementation GVDevHelper
+ (NSTimeInterval)timestamp {
    return round([[NSDate date] timeIntervalSince1970]);
}

+ (NSString *)timestampString {
    return [NSString stringWithFormat:@"%ld", (long)[self timestamp]];
}

+ (void)showNetworkActivityIndicator {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)hideNetworkActivityIndicator {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

+ (UIView *)firstResponder {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    return [keyWindow performSelector:@selector(firstResponder)];
}

+ (int)randomIntegerBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

+ (float)randomFloatBetween:(float)from to:(float)to {
    float diff = to - from;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + from;
}

+ (double)randomDoubleBetween:(double)from to:(double)to {
    double diff = to - from;
    return (((double) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + from;
}

+ (BOOL)randomBool {
    return arc4random_uniform(100) % 2;
}

+ (NSString *)randomStringWithRandomLengthBetween:(NSUInteger)from to:(NSUInteger)to {
    NSUInteger length = [self randomIntegerBetween:from to:to];
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [[NSMutableString alloc] initWithCapacity:length];
    
    for (int i = 0; i < length; i++){
        NSUInteger rand = arc4random_uniform((u_int32_t)letters.length);
        [randomString appendFormat:@"%C", [letters characterAtIndex:rand]];
    }
    
    return randomString.copy;
}

/// 根据宽度缩放面积
+ (CGSize)fitSizeWithWidth:(CGFloat)fitWidth originSize:(CGSize)originSize {
    return CGSizeMake(fitWidth, originSize.height * fitWidth / originSize.width);
}

+ (unsigned long long)fileSizeWithPath:(NSString *)path
{
    // 总大小
    unsigned long long size = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    BOOL exist = [manager fileExistsAtPath:path isDirectory:&isDir];
    
    // 判断路径是否存在
    if (!exist) return size;
    if (isDir) { // 是文件夹
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:path];
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [path stringByAppendingPathComponent:subPath];
            size += [manager attributesOfItemAtPath:fullPath error:nil].fileSize;
            
        }
    }else{ // 是文件
        size += [manager attributesOfItemAtPath:path error:nil].fileSize;
    }
    return size;
}

+ (void)dimmedApplicationWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    [window tintColorDidChange];
}

+ (void)resetDimmedApplicationWindow {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    [window tintColorDidChange];
}

static CGFloat pixelOne = -1.0f;
+ (CGFloat)pixelOne {
    if (pixelOne < 0) {
        pixelOne = 1 / [[UIScreen mainScreen] scale];
    }
    return pixelOne;
}


+ (NSString *)getDeviceUUID {
#if __has_include(<SSKeychain.h>)
    NSString * currentDeviceUUIDStr = [SSKeychain passwordForService:@" "account:@"uuid"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SSKeychain setPassword: currentDeviceUUIDStr forService:@" "account:@"uuid"];
    } else {
//        GVLogInfo(@"currentDeviceUUIDStr is not nil %@", currentDeviceUUIDStr);
        
    }
    return currentDeviceUUIDStr;
#else
    NSAssert(0, @"请导入 SSKeychain 库");
    return @"";
#endif
    
}

inline NSString * callerInfo() {
    NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:2];
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    [array removeObject:@""];
    
    return [NSString stringWithFormat:@"Stack = %@\nFramework = %@\nMemory address = %@\nClass = %@\nFunction = %@", [array objectAtIndex:0], [array objectAtIndex:1], [array objectAtIndex:2], [array objectAtIndex:3], [array objectAtIndex:4]];
//    DebugLog(@"Stack = %@\nFramework = %@\nMemory address = %@\nClass = %@\nFunction = %@", [array objectAtIndex:0], [array objectAtIndex:1], [array objectAtIndex:2], [array objectAtIndex:3], [array objectAtIndex:4]);
}

@end

@implementation GVDevHelper (Notification)
+ (void)registerNotification {
    
}
@end
