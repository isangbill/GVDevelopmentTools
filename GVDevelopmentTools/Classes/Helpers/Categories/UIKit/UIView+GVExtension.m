//
//  UIView+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIView+GVExtension.h"
#import "UIColor+GVExtension.h"

@implementation UIView (GVExtension)
@dynamic gv_x;
@dynamic gv_y;
@dynamic gv_width;
@dynamic gv_height;

@dynamic gv_size;

@dynamic gv_top;
@dynamic gv_right;
@dynamic gv_left;
@dynamic gv_bottom;

@dynamic gv_centerX;
@dynamic gv_centerY;

@dynamic gv_viewController;

- (CGSize)gv_size
{
    return self.frame.size;
}

- (void)setGv_size:(CGSize)gv_size
{
    CGRect frame = self.bounds;
    frame.size = gv_size;
    self.bounds = frame;
}

- (CGFloat)gv_width
{
    return self.frame.size.width;
}

- (CGFloat)gv_height
{
    return self.frame.size.height;
}

- (void)setGv_width:(CGFloat)gv_width
{
    CGRect frame = self.frame;
    frame.size.width = gv_width;
    self.frame = frame;
}

- (void)setGv_height:(CGFloat)gv_height
{
    CGRect frame = self.frame;
    frame.size.height = gv_height;
    self.frame = frame;
}

- (CGFloat)gv_x
{
    return self.frame.origin.x;
}

- (void)setGv_x:(CGFloat)gv_x
{
    CGRect frame = self.frame;
    frame.origin.x = gv_x;
    self.frame = frame;
}

- (CGFloat)gv_y
{
    return self.frame.origin.y;
}

- (void)setGv_y:(CGFloat)gv_y
{
    CGRect frame = self.frame;
    frame.origin.y = gv_y;
    self.frame = frame;
}

- (CGFloat)gv_centerX
{
    return self.center.x;
}

- (void)setGv_centerX:(CGFloat)gv_centerX
{
    CGPoint center = self.center;
    center.x = gv_centerX;
    self.center = center;
}

- (CGFloat)gv_centerY
{
    return self.center.y;
}

- (void)setGv_centerY:(CGFloat)gv_centerY
{
    CGPoint center = self.center;
    center.y = gv_centerY;
    self.center = center;
}

- (CGFloat)gv_top {
    return self.frame.origin.y;
}

- (CGFloat)gv_right
{
    //    return self.gv_x + self.gv_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)gv_left {
    return self.frame.origin.x;
}

- (CGFloat)gv_bottom
{
    //    return self.gv_y + self.gv_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setGv_right:(CGFloat)gv_right
{
    self.gv_x = gv_right - self.gv_width;
}

- (void)setGv_bottom:(CGFloat)gv_bottom
{
    self.gv_y = gv_bottom - self.gv_height;
}

// 获取 View 所在的 controller
- (nullable UIViewController *)gv_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (BOOL)gv_intersectWithView:(UIView *)view {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

/// 水平居中于父视图
- (void)gv_centerInSuperViewHorizontally {
    if (self.superview) {
        self.gv_x = (self.superview.gv_x - self.gv_width) * 0.5;
    }
}

/// 根据 rect 截图
// TODO: 该方法在真机运行有问题待处理
- (UIImage *)gv_screenShotInRect:(CGRect)rect {
    //for retina displays
    CGFloat scale = 1.0;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = [UIScreen mainScreen].scale;
    }
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, -rect.origin.x * scale, -rect.origin.y * scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGFloat w = rect.size.width;
    if (w > (self.gv_width - rect.origin.x)) {
        w = self.gv_width - rect.origin.x;
    }
    
    CGFloat h = rect.size.height;
    if (h > (self.gv_height - rect.origin.y)) {
        h = self.gv_height - rect.origin.y;
    }
    
    CGRect cropRect = CGRectMake(0, 0, w * scale, h * scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, cropRect);
    image = [[UIImage alloc] initWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return image;
}

- (void)gv_removeAllSubViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)gv_showDebugColor {
    for (UIView *subView in self.subviews) {
        subView.backgroundColor = [UIColor gv_niceColor];
    }
}

- (void)gv_setFrameWithCenter:(CGPoint)center size:(CGSize)size {
    self.center = center;
    self.gv_size = size;
}

- (void)shadowWithColor:(UIColor *)color {
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 8;
}

- (void)addShadow {
    [self shadowWithColor:[UIColor blackColor]];
}

- (void)removeShadow {
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowColor = nil;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 0;
}

NSString *const GVSpringAnimationKey = @"GVSpringAnimationKey";
- (void)actionSpringAnimation {
    NSTimeInterval duration = 0.6;
    CAKeyframeAnimation *springAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    springAnimation.values = @[@.85, @1.15, @.9, @1.0,];
    springAnimation.keyTimes = @[@(0.0 / duration), @(0.15 / duration) , @(0.3 / duration), @(0.45 / duration),];
    springAnimation.duration = duration;
    [self.layer addAnimation:springAnimation forKey:GVSpringAnimationKey];
}

@end
