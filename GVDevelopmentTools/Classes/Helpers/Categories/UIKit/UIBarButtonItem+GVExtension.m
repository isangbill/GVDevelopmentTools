//
//  UIBarButtonItem+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIBarButtonItem+GVExtension.h"

@implementation UIBarButtonItem (GVExtension)
+ (UIBarButtonItem *)gv_itemWithTitle:(NSString *)title font:(UIFont *)font Image:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font ? font : button.titleLabel.font;
    button.frame = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

+ (UIBarButtonItem *)gv_itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font ? font : button.titleLabel.font;
    [button sizeToFit];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}



+ (UIBarButtonItem *)gv_itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (highlightedImage) {
        [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //    button.frame = CGRectMake(0, 0, button.currentImage.size.width, button.currentImage.size.height);
    button.frame = CGRectMake(0, 0, button.currentImage.size.width * 0.6, button.currentImage.size.height * 0.6);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
