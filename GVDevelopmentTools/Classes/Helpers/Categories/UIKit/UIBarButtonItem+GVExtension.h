//
//  UIBarButtonItem+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GVExtension)
+ (UIBarButtonItem *)gv_itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)gv_itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;
@end
