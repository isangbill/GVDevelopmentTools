//
//  UINavigationController+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (GVExtension)<UINavigationControllerDelegate>
@property (nonatomic, strong, readonly) UIViewController *gv_rootViewController;
@end
