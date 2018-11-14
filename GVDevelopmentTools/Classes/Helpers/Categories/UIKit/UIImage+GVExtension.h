//
//  UIImage+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+GVExtension.h"

@interface UIImage (GVExtension)

/**
 根据颜色和 size 生成图片

 @param color 指定颜色
 @param size 指定 size
 @return  生成图片
 */
+ (UIImage *)gv_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据颜色生成图片，size 为默认的 1 * 1

 @param color 指定颜色
 @return 生成图片
 */
+ (UIImage *)gv_imageWithColor:(UIColor *)color;

/**
 根据颜色组和渐变方向以及 size 生成渐变图片

 @param colors 渐变颜色数组
 @param gradientDirectionType 颜色的渐变方向
 @param imgSize 图片的 size
 @return  生成的图片
 */
+ (UIImage *)gv_gradientColorImageFromColors:(NSArray *)colors gradientDirectionType:(UIGradientDirectionType)gradientDirectionType imgSize:(CGSize)imgSize;

/**
 根据指定圆角裁剪图片

 @param cornerRadius 圆角大小
 @return 生成图片
 */
- (UIImage *)gv_roundedWithCornerRadius:(CGFloat)cornerRadius;

/**
 根据指定颜色，改变当前图片的 tintcolor，并生成新的图片·

 @param tintColor 指定 tintColor
 @return  生成图片
 */
- (UIImage *)gv_tintImageWithColor:(UIColor *)tintColor;

/**
 根据指定宽度适配一个和图片本身的宽高一样的 size

 @param fitWidth 指定宽度
 @return 图片本身的宽高一样的 size
 */
- (CGSize)gv_fitSizeWithWidth:(CGFloat)fitWidth;

/**
 *  生成模糊图片
 *
 *  @param blur 模糊级数 (0 ~ 1)
 *
 *  @return 模糊图片
 */
- (UIImage *)gv_blurryWithBlurLevel:(CGFloat)blur;

/**
 *  根据图片名返回一张能够自由拉伸的图片(拉伸了中间的像素点)
 */
+ (UIImage *)gv_stretchableImageWithName:(NSString *)name;

/**
 *  根据图片返回一张能够自由拉伸的图片(拉伸了中间的像素点)
 */
- (UIImage *)gv_strectchableImage;

/**
 对传进来的 UIView 截图，生成一个 UIImage 并返回
 
 @param view 要截图的 UIView
 
 @return UIView 的截图
 */
+ (UIImage *)gv_imageWithView:(UIView *)view;


/**
 对传进来的 UIView 截图，生成一个 UIImage 并返回
 
 @param view         要截图的 UIView
 @param afterUpdates 是否要在界面更新完成后才截图
 
 @return UIView 的截图
 */
+ (UIImage *)gv_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates;

/**
 *  将文字渲染成图片，最终图片和文字一样大
 */
+ (UIImage *)gv_imageWithAttributedString:(NSAttributedString *)attributedString;

@end
