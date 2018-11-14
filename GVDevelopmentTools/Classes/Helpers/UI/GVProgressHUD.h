//
//  GVProgressHUD.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/14.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIView;
@interface GVProgressHUD : NSObject
+ (instancetype)showInView:(UIView *)view;
+ (instancetype)showInView:(UIView *)view animated:(BOOL)animated;
+ (instancetype)showInView:(UIView *)view withInfo:(NSString *)info animated:(BOOL)animated;
+ (void)popForView:(UIView *)view animated:(BOOL)animated;
- (void)hide;
@end
