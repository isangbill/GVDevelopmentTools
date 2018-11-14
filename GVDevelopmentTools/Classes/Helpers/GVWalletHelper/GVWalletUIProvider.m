//
//  GVWalletUIProvider.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/6.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVWalletUIProvider.h"
#import "GVWalletThemeManager.h"

@implementation GVWalletUIProvider
+ (UIView *)separator {
    UIView *separator = [UIView new];
    separator.backgroundColor = [UIColor colorWithRed:222.f / 255.f green:222.f / 255.f blue:222.f / 255.f alpha:1.f];
    return separator;
}

+ (CGFloat)separatorHeiht {
    return 1.f / [UIScreen mainScreen].scale;
}

+ (CGFloat)mainCornerRadius {
    return 10.f;
}

+ (CGFloat)mainEdge {
    return 24.f;
}

+ (CGFloat)mainMargin {
    return 10.f;
}

+ (UIImage *)placeholder {
    UIImage *placeholder = [UIImage imageNamed:@"icon_placeholder"];
    return placeholder;
}

+ (GVBaseButton *)buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor font:(UIFont *)font cornerRadius:(CGFloat)cornerRadius target:(id)target selector:(SEL)selector {
    GVBaseButton *button = [[GVBaseButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
   
    if (cornerRadius) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (GVBaseButton *)mainButtonWithTitle:(NSString *)title cornerRadius:(CGFloat)cornerRadius target:(id)target selector:(SEL)selector {
    return [self buttonWithTitle:title backgroundColor:ThemeManager.mainColor titleColor:[UIColor whiteColor] font:[ThemeManager boldMainFontOfSize:16.f]  cornerRadius:cornerRadius target:target selector:selector];
}

+ (GVBaseButton *)mainButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector {
    return [self buttonWithTitle:title backgroundColor:ThemeManager.mainColor titleColor:[UIColor whiteColor] font:[ThemeManager boldMainFontOfSize:16.f]  cornerRadius:10.f target:target selector:selector];
}
@end
