//
//  GVWalletThemeManager.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/5.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVWalletThemeManager.h"

static GVWalletThemeManager *_manager;

@implementation GVWalletThemeManager

- (UIFont *)mainFontOfSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize];
}

- (UIFont *)boldMainFontOfSize:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:fontSize];
}

- (UIColor *)mainColor {
    if (!_mainColor) {
        _mainColor = [GVWalletThemeManager colorWithHexString:@"#33a02c"];
    }
    return _mainColor;
}

- (UIColor *)mainTextColor {
    if (!_mainTextColor) {
        _mainTextColor = [UIColor darkTextColor];
    }
    return _mainTextColor;
}

- (UIColor *)mainBackgroundColor {
    if (!_mainBackgroundColor) {
        _mainBackgroundColor = [GVWalletThemeManager colorWithHexString:@"#f7f7f7"];
    }
    return _mainBackgroundColor;
}

- (CGFloat)mainCornerRadius {
    if (!_mainCornerRadius) {
        _mainCornerRadius = 10.f;
    }
    return _mainCornerRadius;
}

#pragma mark - singleton
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (id)copyWithZone:(NSZone *)zone {
    return _manager;
}


+ (UIColor *)colorWithHexString:(NSString *)hexString {
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
@end

