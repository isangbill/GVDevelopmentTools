//
//  UIViewController+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GVExtension)
/** 获取和自身处于同一个UINavigationController里的上一个UIViewController */
@property(nonatomic, weak, readonly) UIViewController *gv_previousViewController;

/** 获取上一个UIViewController的title，可用于设置自定义返回按钮的文字 */
@property(nonatomic, copy, readonly) NSString *gv_previousViewControllerTitle;

- (void)setupNavigationBarTitleViewImageName:(NSString *)imageName;

- (void)setupNavigationBarLeftBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)setupNavigationBarRightBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;
@end
