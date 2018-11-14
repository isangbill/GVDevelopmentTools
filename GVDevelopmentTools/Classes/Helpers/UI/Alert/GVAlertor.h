//
//  GVAlertor.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/7.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GVAlertor : NSObject

/**
 展示 Message ，标题为默认的 Info, 点击 ok 就消失

 @param message 需要展示的 message
 */
+ (void)presentAlertWithMessage:(NSString *)message;

/**
 展示带 title 的 Message 弹窗, 点击 ok 就消失

 @param title 弹窗的 title
 @param message 需要展示的 message
 */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message;

/**
 展示带 title 的 Message 弹窗, 点击 ok 就消失, 并调用 action block
 
 @param title 弹窗的 title
 @param message 需要展示的 message
 */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(bool okButtonPressed))completionBlock;


/**
 展示带 title 的 Message 弹窗, 点击按钮消失, 并调用 completionBlock

 @param title 弹窗的 title
 @param message 需要展示的 message
 @param cancelButtonTitle 取消按钮标题
 @param okButtonTitle 确定按钮标题
 @param completionBlock 完成回调
 */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle completionBlock:(void (^)(bool okButtonPressed))completionBlock;
@end
