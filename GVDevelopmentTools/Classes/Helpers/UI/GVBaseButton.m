//
//  GVBaseButton.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/24.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVBaseButton.h"

@interface GVBaseButton ()
@property (nonatomic, strong) CALayer *highlightedBackgroundLayer;
@property (nonatomic, strong) UIColor *originBorderColor;
@end

@implementation GVBaseButton {
    UIColor *_originalBackgroundColor;
    BOOL _resetOriginalBackgroundColorIfNeeded;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self didInitialize];
        
        self.tintColor = [UIColor colorWithRed:49/255.0 green:189/255.0 blue:243/255.0 alpha:1];
        if (!self.adjustsTitleTintColorAutomatically) {
            [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        }
        
        // iOS7以后的button，sizeToFit后默认会自带一个上下的contentInsets，为了保证按钮大小即为内容大小，这里直接去掉，改为一个最小的值。
        self.contentEdgeInsets = UIEdgeInsetsMake(CGFLOAT_MIN, 0, CGFLOAT_MIN, 0);
        _resetOriginalBackgroundColorIfNeeded = YES;
        
    }
    return self;
}

- (void)didInitialize {
    self.adjustsTitleTintColorAutomatically = NO;
    self.adjustsImageTintColorAutomatically = NO;
    
    // 默认接管highlighted和disabled的表现，去掉系统默认的表现
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    self.adjustsButtonWhenHighlighted = YES;
    self.adjustsButtonWhenDisabled = YES;
    
}

//- (void)setHighlighted:(BOOL)highlighted {
//    if (highlighted) {
//        if (_resetOriginalBackgroundColorIfNeeded) {
//            _resetOriginalBackgroundColorIfNeeded = NO;
//            _originalBackgroundColor = self.backgroundColor;
//            self.backgroundColor = [self darkerColorForColor:_originalBackgroundColor];
//        }
//    } else {
//        _resetOriginalBackgroundColorIfNeeded = YES;
//        self.backgroundColor = _originalBackgroundColor;
//    }
//
//    [super setHighlighted:highlighted];
//}
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted && !self.originBorderColor) {
        // 手指按在按钮上会不断触发setHighlighted:，所以这里做了保护，设置过一次就不用再设置了
        self.originBorderColor = [UIColor colorWithCGColor:self.layer.borderColor];
    }
    
    // 渲染背景色
    if (self.highlightedBackgroundColor || self.highlightedBorderColor) {
        [self adjustsButtonHighlighted];
    }
    // 如果此时是disabled，则disabled的样式优先
    if (!self.enabled) {
        return;
    }
    // 自定义highlighted样式
    if (self.adjustsButtonWhenHighlighted) {
        if (highlighted) {
            self.alpha = 0.5f;
        } else {
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 1;
            }];
        }
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (!enabled && self.adjustsButtonWhenDisabled) {
        self.alpha = 0.5f;
    } else {
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 1;
        }];
    }
}

- (void)adjustsButtonHighlighted {
    if (self.highlightedBackgroundColor) {
        if (!self.highlightedBackgroundLayer) {
            self.highlightedBackgroundLayer = [CALayer layer];
//            [self.highlightedBackgroundLayer qmui_removeDefaultAnimations];
            [self.layer insertSublayer:self.highlightedBackgroundLayer atIndex:0];
        }
        self.highlightedBackgroundLayer.frame = self.bounds;
        self.highlightedBackgroundLayer.cornerRadius = self.layer.cornerRadius;
        self.highlightedBackgroundLayer.backgroundColor = self.highlighted ? self.highlightedBackgroundColor.CGColor : [UIColor clearColor].CGColor;
    }
    
    if (self.highlightedBorderColor) {
        self.layer.borderColor = self.highlighted ? self.highlightedBorderColor.CGColor : self.originBorderColor.CGColor;
    }
}

- (void)setAdjustsTitleTintColorAutomatically:(BOOL)adjustsTitleTintColorAutomatically {
    _adjustsTitleTintColorAutomatically = adjustsTitleTintColorAutomatically;
    [self updateTitleColorIfNeeded];
}

- (void)updateTitleColorIfNeeded {
    if (self.adjustsTitleTintColorAutomatically && self.currentTitleColor) {
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    }
    if (self.adjustsTitleTintColorAutomatically && self.currentAttributedTitle) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.currentAttributedTitle];
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.tintColor range:NSMakeRange(0, attributedString.length)];
        [self setAttributedTitle:attributedString forState:UIControlStateNormal];
    }
}

- (void)setAdjustsImageTintColorAutomatically:(BOOL)adjustsImageTintColorAutomatically {
    BOOL valueDifference = _adjustsImageTintColorAutomatically != adjustsImageTintColorAutomatically;
    _adjustsImageTintColorAutomatically = adjustsImageTintColorAutomatically;
    
    if (valueDifference) {
        [self updateImageRenderingModeIfNeeded];
    }
}

- (void)updateImageRenderingModeIfNeeded {
    if (self.currentImage) {
        NSArray<NSNumber *> *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateSelected), @(UIControlStateSelected|UIControlStateHighlighted), @(UIControlStateDisabled)];
        
        // 实际上对于 UIButton 而言如果设置了 UIControlStateNormal 的 image，则其他所有 state 下的 image 默认都会返回 normal 这张图，所以这个判断只对 UIControlStateNormal 做就行了
        UIImage *normalImage = [self imageForState:UIControlStateNormal];
        if (!normalImage) return;
        
        for (NSNumber *number in states) {
//            if (number.unsignedIntegerValue > UIControlStateNormal && [self qmui_hasCustomizedButtonPropWithType:QMUICustomizeButtonPropTypeImage forState:number.unsignedIntegerValue]) {
//                // 这个 state 自定义过 image，就不用处理
//                continue;
//            }
            
            UIImage *image = [self imageForState:number.unsignedIntegerValue];
            
            if (self.adjustsImageTintColorAutomatically) {
                // 这里的 setImage: 操作不需要使用 renderingMode 对 image 重新处理，而是放到重写的 setImage:forState 里去做就行了
                [self setImage:image forState:[number unsignedIntegerValue]];
            } else {
                // 如果不需要用template的模式渲染，并且之前是使用template的，则把renderingMode改回Original
                [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:[number unsignedIntegerValue]];
            }
        }
    }
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    [self updateTitleColorIfNeeded];
    
    if (self.adjustsImageTintColorAutomatically) {
        [self updateImageRenderingModeIfNeeded];
    }
}

- (void)setTintColorAdjustsTitleAndImage:(UIColor *)tintColorAdjustsTitleAndImage {
    if (tintColorAdjustsTitleAndImage) {
        self.tintColor = tintColorAdjustsTitleAndImage;
        self.adjustsTitleTintColorAutomatically = YES;
        self.adjustsImageTintColorAutomatically = YES;
    }
}

- (UIColor *)tintColorAdjustsTitleAndImage {
    return self.tintColor;
}

#pragma mark - Helpers
- (UIColor *)darkerColorForColor:(UIColor *)color
{
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2f, 0.0f)
                               green:MAX(g - 0.2f, 0.0f)
                                blue:MAX(b - 0.2f, 0.0f)
                               alpha:a];
    return nil;
}

- (UIColor *)lighterColorForColor:(UIColor *)color
{
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2f, 1.0f)
                               green:MIN(g + 0.2f, 1.0f)
                                blue:MIN(b + 0.2f, 1.0f)
                               alpha:a];
    return nil;
}
@end

