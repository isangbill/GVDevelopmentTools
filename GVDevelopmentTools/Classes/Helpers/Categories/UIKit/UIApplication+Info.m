//
//  UIApplication+Info.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/13.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIApplication+Info.h"

@implementation UIApplication (Info)
+ (NSString *)gv_currentVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}
@end
