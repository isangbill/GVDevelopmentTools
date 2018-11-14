//
//  GVWalletThemeManager.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/5.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ThemeManager [GVWalletThemeManager sharedManager]

@interface GVWalletThemeManager : NSObject {
    UIColor *_mainColor;
}

@property (nonatomic, strong) UIColor *mainColor;
@property (nonatomic, strong) UIColor *mainTextColor;
@property (nonatomic, strong) UIColor *mainBackgroundColor;
@property (nonatomic, assign) CGFloat mainCornerRadius;

- (UIFont *)mainFontOfSize:(CGFloat)fontSize;
- (UIFont *)boldMainFontOfSize:(CGFloat)fontSize;


+ (instancetype)sharedManager;
@end
