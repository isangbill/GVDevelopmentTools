//
//  UIImage+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIImage+GVExtension.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (GVExtension)
/// 通过颜色来生成一个纯色图片
+ (UIImage *)gv_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/// 通过颜色来生成一个纯色图片
+ (UIImage *)gv_imageWithColor:(UIColor *)color {
    return [UIImage gv_imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

+ (UIImage *)gv_gradientColorImageFromColors:(NSArray *)colors gradientDirectionType:(UIGradientDirectionType)gradientDirectionType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientDirectionType) {
        case UIGradientDirectionTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case UIGradientDirectionTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case UIGradientDirectionTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case UIGradientDirectionTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)gv_roundedWithCornerRadius:(CGFloat)cornerRadius {
    
    UIImage* imageNew;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    
    const CGRect RECT = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:RECT cornerRadius:cornerRadius] addClip];
    [self drawInRect:RECT];
    imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

- (UIImage *)gv_tintImageWithColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, self.CGImage);
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    
    CGContextFillRect(context, rect);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}

/// 根据指定宽度缩放图片, 返回缩放后的 size
- (CGSize)gv_fitSizeWithWidth:(CGFloat)fitWidth {
    
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    
    if (width > fitWidth) {
        height *= fitWidth/width;
        width = fitWidth;
    }
    
    return CGSizeMake(width, height);
}

- (UIImage *)gv_blurryWithBlurLevel:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f)
    {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData      = CGDataProviderCopyData(inProvider);
    
    inBuffer.width    = CGImageGetWidth(img);
    inBuffer.height  = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if (pixelBuffer == NULL)
    {
        NSLog(@"No pixelbuffer");
    }
    
    outBuffer.data    = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(img);
    outBuffer.height  = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error)
    {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx          = CGBitmapContextCreate(
                                                      outBuffer.data,
                                                      outBuffer.width,
                                                      outBuffer.height,
                                                      8,
                                                      outBuffer.rowBytes,
                                                      colorSpace,
                                                      kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef  = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (UIImage *)gv_stretchableImageWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

- (UIImage *)strectchableImage {
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}


+ (UIImage *)gv_imageWithAttributedString:(NSAttributedString *)attributedString {
    CGSize stringSize = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    stringSize = CGSizeMake(ceilf(stringSize.width), ceilf(stringSize.height));
    UIGraphicsBeginImageContextWithOptions(stringSize, NO, 0);
    [attributedString drawInRect:CGRectMake(0, 0, stringSize.width, stringSize.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)gv_imageWithView:(UIView *)view {
    //    CGContextInspectSize(view.frame.size);
    // 老方式，因为drawViewHierarchyInRect:afterScreenUpdates:有一定的使用条件，有些情况下不一定截得到图，所有这种情况下可以使用老方式。
    // 如果可以用新方式，则建议使用新方式，性能上好很多
    UIImage *resultImage = nil;
    // 第二个参数是不透明度，这里默认设置为YES，不用出来alpha通道的事情，可以提高性能
    // 第三个参数是scale，设置为0的时候，意思是使用屏幕的scale
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextInspectContext(context);
    [view.layer renderInContext:context];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)gv_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates {
    // iOS7截图新方式，性能好会好一点，不过不一定适用，因为这个方法的使用条件是：界面要已经render完，否则截到得图将会是empty。
    // 如果是iOS6调用这个接口，将会使用老的方式。
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        UIImage *resultImage = nil;
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
        [view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) afterScreenUpdates:afterUpdates];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    } else {
        return [self gv_imageWithView:view];
    }
}
@end
