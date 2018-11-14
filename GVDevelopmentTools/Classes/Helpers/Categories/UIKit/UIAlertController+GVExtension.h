//
//  UIAlertController+GVExtension.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/7.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (GVExtension)
- (void)gv_setTitle:(NSString *)title withFont:(UIFont *)font textColor:(UIColor *)textColor;
- (void)gv_setTitle:(NSString *)title withTextColor:(UIColor *)textColor;
- (void)gv_setTitle:(NSString *)title withFont:(UIFont *)font;
- (void)gv_setTitle:(NSString *)title;

- (void)gv_addActionWithTitle:(NSString *)title textColor:(UIColor *)textColor icon:(UIImage *)icon style:(UIAlertActionStyle)style enable:(BOOL)enable handler:(void (^)(UIAlertAction *))handler;

- (void)gv_addActionWithTitle:(NSString *)title textColor:(UIColor *)textColor style:(UIAlertActionStyle)style enable:(BOOL)enable handler:(void(^)(UIAlertAction *))handler;
@end
