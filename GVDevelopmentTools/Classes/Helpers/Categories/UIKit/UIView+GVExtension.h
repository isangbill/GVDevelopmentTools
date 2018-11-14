//
//  UIView+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GVExtension)
@property (nonatomic, assign) CGSize gv_size;
@property (nonatomic, assign) CGFloat gv_width;
@property (nonatomic, assign) CGFloat gv_height;
@property (nonatomic, assign) CGFloat gv_x;
@property (nonatomic, assign) CGFloat gv_y;
@property (nonatomic, assign) CGFloat gv_centerX;
@property (nonatomic, assign) CGFloat gv_centerY;

@property (assign, nonatomic) CGFloat gv_top;
@property (nonatomic, assign) CGFloat gv_right;
@property (assign, nonatomic) CGFloat gv_left;
@property (nonatomic, assign) CGFloat gv_bottom;
@property (nonatomic, strong, readonly) UIViewController *gv_viewController;

/**
 是否与某个 view 相交

 @param view 和 self 比较的 view
 @return 相交返回 YES，反之 NO
 */
- (BOOL)gv_intersectWithView:(UIView *)view;

/**
 根据 rect 截图, 该方法在真机运行有问题待处理, 建议使用 UIImage 的扩展方法

 @param rect 被截图的区域
 @return 区域截图生成的图片
 */
// TODO: 该方法在真机运行有问题待处理
- (UIImage *)gv_screenShotInRect:(CGRect)rect;

/**
 删除所有子控件
 */
- (void)gv_removeAllSubViews;

/**
 Debug UIView 的时候用，对某个 view 的 subviews 都添加随机背景色，
 方便查看 view 的布局情况
 */
- (void)gv_showDebugColor;

/**
 *  根据 center 和 size 设置 frame
 *
 *  @param center center
 *  @param size   size
 */
- (void)gv_setFrameWithCenter:(CGPoint)center size:(CGSize)size;

/**
 水平居中于父视图
 */
- (void)gv_centerInSuperViewHorizontally;

/**
 添加指定颜色的阴影

 @param color 阴影颜色
 */
- (void)shadowWithColor:(UIColor *)color;

/**
 添加一个默认的阴影
 */
- (void)addShadow;

/**
 移除阴影
 */
- (void)removeShadow;


/**
 警示动画
 */
- (void)actionSpringAnimation;
@end
