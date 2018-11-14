//
//  UIDevice+Display.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/12.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import "UIDevice+Display.h"

@implementation UIDevice (Display)
+ (BOOL)isFullDisplayScreen {
    static BOOL isFullDisplayScreen = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *fullDisplayGenerations = @[@"iPhone X", @"iPhone X", @"iPhone XS", @"iPhone XS Max"];
        NSString *generation = [UIDevice deviceGeneration];
        isFullDisplayScreen = [fullDisplayGenerations containsObject:generation];
    });
    return isFullDisplayScreen;
}

+ (NSString *)deviceGeneration {
    static dispatch_once_t one;
    static NSString *generation;
    dispatch_once(&one, ^{
        NSString *model = [[UIDevice currentDevice] model];
        if (!model) return;
        NSDictionary *dic = @{
                              @"iPhone1,1" : @"iPhone",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              @"iPhone10,1" : @"iPhone 8",
                              @"iPhone10,4" : @"iPhone 8",
                              @"iPhone10,2" : @"iPhone 8 Plus",
                              @"iPhone10,5" : @"iPhone 8 Plus",
                              @"iPhone10,3" : @"iPhone X",
                              @"iPhone10,6" : @"iPhone X",
                              @"iPhone11,2" : @"iPhone XS",
                              @"iPhone11,4" : @"iPhone XS Max",
                              @"iPhone11,6" : @"iPhone XS Max",
                              @"iPhone11,8" : @"iPhone XR",
                              
                              };
        generation = dic[model];
    });
    return generation;
}
@end
