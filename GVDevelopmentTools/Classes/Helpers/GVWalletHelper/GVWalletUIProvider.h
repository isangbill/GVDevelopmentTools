//
//  GVWalletUIProvider.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/6.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GVBaseButton.h"

@interface GVWalletUIProvider : NSObject

+ (UIView *)separator;
+ (CGFloat)separatorHeiht;
+ (CGFloat)mainCornerRadius;
+ (CGFloat)mainMargin;
+ (CGFloat)mainEdge;
+ (UIImage *)placeholder;

+ (GVBaseButton *)mainButtonWithTitle:(NSString *)title cornerRadius:(CGFloat)cornerRadius target:(id)target selector:(SEL)selector;

+ (GVBaseButton *)mainButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

+ (GVBaseButton *)buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor font:(UIFont *)font cornerRadius:(CGFloat)cornerRadius target:(id)target selector:(SEL)selector;
@end
