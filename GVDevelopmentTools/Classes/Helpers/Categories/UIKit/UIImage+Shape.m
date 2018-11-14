//
//  UIImage+Shape.m
//  GVDevelopHelper
//
//  Created by Sangbill on 2018/9/3.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIImage+Shape.h"
/// 传入size，返回一个x/y为0的CGRect
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}

@implementation UIImage (Shape)
+ (UIImage *)imageWithShape:(GVImageShape)shape size:(CGSize)size lineWidth:(CGFloat)lineWidth tintColor:(UIColor *)tintColor {
//    size = CGSizeFlatted(size);
//    CGContextInspectSize(size);
    
    tintColor = tintColor ? : [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    {
        UIBezierPath *path = nil;
        BOOL drawByStroke = NO;
        CGFloat drawOffset = lineWidth / 2;
        switch (shape) {
            case GVImageShapeOval: {
                path = [UIBezierPath bezierPathWithOvalInRect:CGRectMakeWithSize(size)];
            }
                break;
            case GVImageShapeTriangle: {
                path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(0, size.height)];
                [path addLineToPoint:CGPointMake(size.width / 2, 0)];
                [path addLineToPoint:CGPointMake(size.width, size.height)];
                [path closePath];
            }
                break;
            case GVImageShapeNavBack: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPath];
                path.lineWidth = lineWidth;
                [path moveToPoint:CGPointMake(size.width - drawOffset, drawOffset)];
                [path addLineToPoint:CGPointMake(0 + drawOffset, size.height / 2.0)];
                [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height - drawOffset)];
            }
                break;
            case GVImageShapeDisclosureIndicator: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPath];
                path.lineWidth = lineWidth;
                [path moveToPoint:CGPointMake(drawOffset, drawOffset)];
                [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height / 2)];
                [path addLineToPoint:CGPointMake(drawOffset, size.height - drawOffset)];
            }
                break;
            case GVImageShapeCheckmark: {
                CGFloat lineAngle = M_PI_4;
                path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(0, size.height / 2)];
                [path addLineToPoint:CGPointMake(size.width / 3, size.height)];
                [path addLineToPoint:CGPointMake(size.width, lineWidth * sin(lineAngle))];
                [path addLineToPoint:CGPointMake(size.width - lineWidth * cos(lineAngle), 0)];
                [path addLineToPoint:CGPointMake(size.width / 3, size.height - lineWidth / sin(lineAngle))];
                [path addLineToPoint:CGPointMake(lineWidth * sin(lineAngle), size.height / 2 - lineWidth * sin(lineAngle))];
                [path closePath];
            }
                break;
            case GVImageShapeDetailButtonImage: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMakeWithSize(size), drawOffset, drawOffset)];
                path.lineWidth = lineWidth;
            }
                break;
            case GVImageShapeNavClose: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPath];
                [path moveToPoint:CGPointMake(0, 0)];
                [path addLineToPoint:CGPointMake(size.width, size.height)];
                [path closePath];
                [path moveToPoint:CGPointMake(size.width, 0)];
                [path addLineToPoint:CGPointMake(0, size.height)];
                [path closePath];
                path.lineWidth = lineWidth;
                path.lineCapStyle = kCGLineCapRound;
            }
                break;
            case GVImageShapeNavForward: {
                drawByStroke = YES;
                path = [UIBezierPath bezierPath];
                path.lineWidth = lineWidth;
                [path moveToPoint:CGPointMake(0 + drawOffset, drawOffset)];
                [path addLineToPoint:CGPointMake(size.width - drawOffset, size.height / 2.0)];
                [path addLineToPoint:CGPointMake(0 + drawOffset, size.height - drawOffset)];
            }
                break;
            default:
                break;
        }
        
        if (drawByStroke) {
            CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
            [path stroke];
        } else {
            CGContextSetFillColorWithColor(context, tintColor.CGColor);
            [path fill];
        }
        
        if (shape == GVImageShapeDetailButtonImage) {
            CGFloat fontPointSize = (size.height * 0.8);
            UIFont *font = [UIFont fontWithName:@"Georgia" size:fontPointSize];
            NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"i" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: tintColor}];
            CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingUsesFontLeading context:nil].size;
            
            [string drawAtPoint:CGPointMake(((size.width - stringSize.width) / 2.0), ((size.height - stringSize.height) / 2.0))];
        }
    }
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageOut;
}

+ (UIImage *)imageWithShape:(GVImageShape)shape size:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat lineWidth = 0;
    switch (shape) {
        case GVImageShapeNavBack:
            lineWidth = 2.0f;
            break;
        case GVImageShapeDisclosureIndicator:
            lineWidth = 1.5f;
            break;
        case GVImageShapeCheckmark:
            lineWidth = 1.5f;
            break;
        case GVImageShapeDetailButtonImage:
            lineWidth = 1.0f;
            break;
        case GVImageShapeNavClose:
            lineWidth = 1.2f;   // 取消icon默认的lineWidth
            break;
        case GVImageShapeNavForward:
            lineWidth = 2.0f;
            break;
        default:
            break;
    }
    return [UIImage imageWithShape:shape size:size lineWidth:lineWidth tintColor:tintColor];
}

@end
