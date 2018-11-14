//
//  UIColor+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIColor+GVExtension.h"
#import "NSString+GVExtension.h"
#import "UIImage+GVExtension.h"

@implementation UIColor (GVExtension)
+ (UIColor *)gv_colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

- (NSString *)gv_hexString {
    NSInteger alpha = self.gv_alpha * 255;
    NSInteger red = self.gv_red * 255;
    NSInteger green = self.gv_green * 255;
    NSInteger blue = self.gv_blue * 255;
    return [[NSString stringWithFormat:@"#%@%@%@%@",
             [self alignColorHexStringLength:[NSString gv_hexStringWithInteger:alpha]],
             [self alignColorHexStringLength:[NSString gv_hexStringWithInteger:red]],
             [self alignColorHexStringLength:[NSString gv_hexStringWithInteger:green]],
             [self alignColorHexStringLength:[NSString gv_hexStringWithInteger:blue]]] lowercaseString];
}

// 对于色值只有单位数的，在前面补一个0，例如“F”会补齐为“0F”
- (NSString *)alignColorHexStringLength:(NSString *)hexString {
    return hexString.length < 2 ? [@"0" stringByAppendingString:hexString] : hexString;
}

- (CGFloat)gv_red {
    CGFloat r;
    if ([self getRed:&r green:0 blue:0 alpha:0]) {
        return r;
    }
    return 0;
}

- (CGFloat)gv_green {
    CGFloat g;
    if ([self getRed:0 green:&g blue:0 alpha:0]) {
        return g;
    }
    return 0;
}

- (CGFloat)gv_blue {
    CGFloat b;
    if ([self getRed:0 green:0 blue:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (CGFloat)gv_alpha {
    CGFloat a;
    if ([self getRed:0 green:0 blue:0 alpha:&a]) {
        return a;
    }
    return 0;
}

- (CGFloat)gv_hue {
    CGFloat h;
    if ([self getHue:&h saturation:0 brightness:0 alpha:0]) {
        return h;
    }
    return 0;
}

- (CGFloat)gv_saturation {
    CGFloat s;
    if ([self getHue:0 saturation:&s brightness:0 alpha:0]) {
        return s;
    }
    return 0;
}

- (CGFloat)gv_brightness {
    CGFloat b;
    if ([self getHue:0 saturation:0 brightness:&b alpha:0]) {
        return b;
    }
    return 0;
}

- (UIColor *)gv_colorWithoutAlpha {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    if ([self getRed:&r green:&g blue:&b alpha:0]) {
        return [UIColor colorWithRed:r green:g blue:b alpha:1];
    } else {
        return nil;
    }
}

- (UIColor *)gv_colorWithAlpha:(CGFloat)alpha backgroundColor:(UIColor *)backgroundColor {
    return [UIColor gv_colorWithBackendColor:backgroundColor frontColor:[self colorWithAlphaComponent:alpha]];
    
}

- (UIColor *)gv_whiteColorWithAlpha:(CGFloat)alpha {
    return [self gv_colorWithAlpha:alpha backgroundColor:[UIColor whiteColor]];
}

- (UIColor *)gv_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress {
    return [UIColor gv_colorFromColor:self toColor:toColor progress:progress];
}

+ (UIColor *)gv_colorWithBackendColor:(UIColor *)backendColor frontColor:(UIColor *)frontColor {
    CGFloat bgAlpha = [backendColor gv_alpha];
    CGFloat bgRed = [backendColor gv_red];
    CGFloat bgGreen = [backendColor gv_green];
    CGFloat bgBlue = [backendColor gv_blue];
    
    CGFloat frAlpha = [frontColor gv_alpha];
    CGFloat frRed = [frontColor gv_red];
    CGFloat frGreen = [frontColor gv_green];
    CGFloat frBlue = [frontColor gv_blue];
    
    CGFloat resultAlpha = frAlpha + bgAlpha * (1 - frAlpha);
    CGFloat resultRed = (frRed * frAlpha + bgRed * bgAlpha * (1 - frAlpha)) / resultAlpha;
    CGFloat resultGreen = (frGreen * frAlpha + bgGreen * bgAlpha * (1 - frAlpha)) / resultAlpha;
    CGFloat resultBlue = (frBlue * frAlpha + bgBlue * bgAlpha * (1 - frAlpha)) / resultAlpha;
    return [UIColor colorWithRed:resultRed green:resultGreen blue:resultBlue alpha:resultAlpha];
}

+ (UIColor *)gv_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    progress = MIN(progress, 1.0f);
    CGFloat fromRed = fromColor.gv_red;
    CGFloat fromGreen = fromColor.gv_green;
    CGFloat fromBlue = fromColor.gv_blue;
    CGFloat fromAlpha = fromColor.gv_alpha;
    
    CGFloat toRed = toColor.gv_red;
    CGFloat toGreen = toColor.gv_green;
    CGFloat toBlue = toColor.gv_blue;
    CGFloat toAlpha = toColor.gv_alpha;
    
    CGFloat finalRed = fromRed + (toRed - fromRed) * progress;
    CGFloat finalGreen = fromGreen + (toGreen - fromGreen) * progress;
    CGFloat finalBlue = fromBlue + (toBlue - fromBlue) * progress;
    CGFloat finalAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    
    return [UIColor colorWithRed:finalRed green:finalGreen blue:finalBlue alpha:finalAlpha];
}

+ (UIColor *)gv_randomColor {
    CGFloat red = ( arc4random() % 255 / 255.0 );
    CGFloat green = ( arc4random() % 255 / 255.0 );
    CGFloat blue = ( arc4random() % 255 / 255.0 );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (BOOL)gv_isDarkColor {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    float referenceValue = 0.411;
    float colorDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
    
    return 1.0 - colorDelta > referenceValue;
}

- (UIColor *)gv_inverseColor {
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    UIColor *newColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                               green:(1.0 - componentColors[1])
                                                blue:(1.0 - componentColors[2])
                                               alpha:componentColors[3]];
    return newColor;
}

+ (UIColor *)gv_niceColor {
    NSArray *niceColors = @[
                            [UIColor colorWithRed:0.55 green:0.27  blue:0.64  alpha:1],
                            [UIColor colorWithRed:0.34 green:0.16  blue:0.86  alpha:1],
                            [UIColor colorWithRed:0 green:1  blue:0.4  alpha:1],
                            [UIColor colorWithRed:0.99 green:0.32  blue:0  alpha:1],
                            [UIColor colorWithRed:0.15 green:0.49  blue:0.89  alpha:1],
                            [UIColor colorWithRed:0.99 green:0.72  blue:0  alpha:1],
                            [UIColor colorWithRed:0.06 green:0.2  blue:0.49  alpha:1],
                            [UIColor colorWithRed:0.74 green:0.13  blue:0.11  alpha:1],
                            [UIColor colorWithRed:0.82 green:0.14  blue:0.07  alpha:1],
                            [UIColor colorWithRed:0.1 green:0.07  blue:0.52  alpha:1],
                            [UIColor colorWithRed:0.2 green:0.85  blue:0.72  alpha:1],
                            [UIColor colorWithRed:0.21 green:0.86  blue:0.44  alpha:1],
                            [UIColor colorWithRed:0 green:0.95  blue:0.91  alpha:1],
                            [UIColor colorWithRed:1 green:0.1  blue:0.17  alpha:1],
                            [UIColor colorWithRed:1 green:0.8  blue:0.16  alpha:1],
                            [UIColor colorWithRed:0.98 green:0.58  blue:0.77  alpha:1],
                            [UIColor colorWithRed:1 green:0.35  blue:0.4  alpha:1],
                            [UIColor colorWithRed:0 green:0.58  blue:0.29  alpha:1],
                            [UIColor colorWithRed:0 green:0.78  blue:0.6  alpha:1],
                            [UIColor colorWithRed:0.51 green:0.15  blue:0.99  alpha:1],
                            [UIColor colorWithRed:1 green:0.22  blue:0  alpha:1],
                            [UIColor colorWithRed:0.99 green:0.89  blue:0  alpha:1]];
    
    int randomRoll = arc4random_uniform((UInt32)niceColors.count - 1);
    return niceColors[randomRoll];
}


+ (UIColor *)gv_gradientColorFromColors:(nonnull NSArray *)colors gradientDirectionType:(UIGradientDirectionType)gradientDirectionType size:(CGSize)size {
    if ((colors.count < 2) || CGSizeEqualToSize(size, CGSizeZero)) {
        if (colors.count == 1) {
            return colors.firstObject;
        }
        return [self blackColor];
    }
    UIImage *gradientColorImg = [UIImage gv_gradientColorImageFromColors:colors gradientDirectionType:gradientDirectionType imgSize:size];
    return [self colorWithPatternImage:gradientColorImg];
}

+ (UIColor *)gv_darkBlueColor {
    return [UIColor colorWithRed:70.0/255.0 green:102.0/255.0 blue:118.0/255.0 alpha:1.0];
}

+ (UIColor *)gv_lightBlueColor {
    return [UIColor colorWithRed:70.0/255.0 green:165.0/255.0 blue:196.0/255.0 alpha:1.0];
}

- (UIColor *)gv_darkerColor {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2f, 0.0f)
                               green:MAX(g - 0.2f, 0.0f)
                                blue:MAX(b - 0.2f, 0.0f)
                               alpha:a];
    return nil;
}

- (UIColor *)gv_lighterColor {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2f, 1.0f)
                               green:MIN(g + 0.2f, 1.0f)
                                blue:MIN(b + 0.2f, 1.0f)
                               alpha:a];
    return nil;
}
@end
