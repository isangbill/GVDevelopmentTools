//
//  UIDevice+UUID.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/13.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIDevice+UUID.h"
//#if __has_include(<SSKeychain.h>)
#import "SSKeychain.h"
//#endif
@implementation UIDevice (UUID)
+ (NSString *)gv_deviceUUID {
//#if __has_include(<SSKeychain.h>)
    NSString * currentDeviceUUIDStr = [SSKeychain passwordForService:@" "account:@"uuid"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SSKeychain setPassword: currentDeviceUUIDStr forService:@" "account:@"uuid"];
    } else {
        NSLog(@"currentDeviceUUIDStr is not nil %@", currentDeviceUUIDStr);
        
    }
   
#if TARGET_IPHONE_SIMULATOR
    /// 将模拟器的 UUID 设置成 iPhone X 相同的，避免多点登录检测
    currentDeviceUUIDStr = @"b52980037b2945e48ee524c916c38cda";
#endif
    
    return currentDeviceUUIDStr;
//#else
//    NSAssert(0, @"请导入 SSKeychain 库");
//    return @"";
//#endif
    
}
@end
