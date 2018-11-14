//
//  UIAlertController+GVExtension.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/7.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIAlertController+GVExtension.h"

@implementation UIAlertController (GVExtension)
- (void)gv_setTitle:(NSString *)title withFont:(UIFont *)font textColor:(UIColor *)textColor {
    if (!title) {
        return;
    }
    
    self.title = title;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    if (font) {
        [attrs setObject:font forKey:NSFontAttributeName];
    }
    
    if (textColor) {
        [attrs setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:[attrs copy]];
    
    [self setValue:attributedTitle forKey:@"attributedTitle"];
}

- (void)gv_setTitle:(NSString *)title withTextColor:(UIColor *)textColor {
    [self gv_setTitle:title withFont:nil textColor:textColor];
}

- (void)gv_setTitle:(NSString *)title withFont:(UIFont *)font {
    [self gv_setTitle:title withFont:font textColor:nil];
}

- (void)gv_addActionWithTitle:(NSString *)title textColor:(UIColor *)textColor icon:(UIImage *)icon style:(UIAlertActionStyle)style enable:(BOOL)enable handler:(void (^)(UIAlertAction *))handler {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    if (icon) {
        [action setValue:icon forKey:@"image"];
    }
    if (textColor) {
        [action setValue:textColor forKey:@"titleTextColor"];
    }
    
    [self addAction:action];
}

@end
