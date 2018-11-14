//
//  UIImage+Shape.h
//  GVDevelopHelper
//
//  Created by Sangbill on 2018/9/3.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GVImageShape) {
    GVImageShapeOval,                 // 椭圆
    GVImageShapeTriangle,             // 三角形
    GVImageShapeDisclosureIndicator,  // 列表 cell 右边的箭头
    GVImageShapeCheckmark,            // 列表 cell 右边的checkmark
    GVImageShapeDetailButtonImage,    // 列表 cell 右边的 i 按钮图片
    GVImageShapeNavBack,              // 返回按钮的箭头
    GVImageShapeNavClose,              // 导航栏的关闭icon
    GVImageShapeNavForward              // 导航栏的向右
};

@interface UIImage (Shape)
/**
 *  创建一个指定大小和颜色的形状图片
 *  @param shape 图片形状
 *  @param size 图片大小
 *  @param tintColor 图片颜色
 */
+ (UIImage *)imageWithShape:(GVImageShape)shape size:(CGSize)size tintColor:(UIColor *)tintColor;

/**
 *  创建一个指定大小和颜色的形状图片
 *  @param shape 图片形状
 *  @param size 图片大小
 *  @param lineWidth 路径大小，不会影响最终size
 *  @param tintColor 图片颜色
 */
+ (UIImage *)imageWithShape:(GVImageShape)shape size:(CGSize)size lineWidth:(CGFloat)lineWidth tintColor:(UIColor *)tintColor;

@end
