//
//  UILabel+Clickable.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/11.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UILabel+Clickable.h"
#import <objc/runtime.h>

@implementation UILabel (Clickable)
- (void)gv_addClickableRange:(NSRange)clickableRange withUnderline:(BOOL)underline highlightedColor:(UIColor *)highlightedColor actionBlock:(void (^)(void))actionBlock {
    if (clickableRange.location == NSNotFound) {
        return;
    }
    
    if (!self.tap) {
        self.tap = [UITapGestureRecognizer new];
        [self addGestureRecognizer:self.tap];
        [self.tap addTarget:self action:@selector(_tapAction:)];
        self.userInteractionEnabled = YES;
        
        if (!self.clickabelTextActionMap) {
            self.clickabelTextActionMap = [NSMutableDictionary dictionary];
        }
    }
    
    if (actionBlock) {
        [self.clickabelTextActionMap setObject:actionBlock forKey:NSStringFromRange(clickableRange)];
    }
    
    NSAttributedString *attributedText = self.attributedText;
    if (!attributedText) {
        attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSFontAttributeName : self.font, NSForegroundColorAttributeName : self.textColor}];
    }
    
    NSMutableAttributedString *mats = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    
    [mats addAttribute:NSForegroundColorAttributeName value:highlightedColor range:clickableRange];
    if (underline) {
        [mats addAttributes:@{
                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), NSUnderlineColorAttributeName : highlightedColor
                              
                              }
                      range:clickableRange];
    }
    
    self.attributedText = mats.copy;
    
}

#pragma mark - private methods
- (void)_tapAction:(UITapGestureRecognizer *)tap {
    for (NSString *rangeString in self.clickabelTextActionMap.allKeys) {
        NSRange range = NSRangeFromString(rangeString);
        if (range.location != NSNotFound) {
            if ([self _didTap:tap attributedTextInLabel:self inRange:range]) {
                void (^action)(void)  = self.clickabelTextActionMap[rangeString];
                action();
                break;
            }
        }
    }
}

- (BOOL)_didTap:(UITapGestureRecognizer *)tap attributedTextInLabel:(UILabel *)label inRange:(NSRange)targetRange {
    // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
    NSLayoutManager *layouManager = [NSLayoutManager new];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:label.attributedText];
    
    // Configure layoutManager and textStorage
    [layouManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layouManager];
    
    // Configure textContainer
    textContainer.lineFragmentPadding = 0.f;
    textContainer.lineBreakMode = label.lineBreakMode;
    textContainer.maximumNumberOfLines = label.numberOfLines;
    textContainer.size = label.frame.size;
    
    // Find the tapped character location and compare it to the specified range
    CGPoint locationOfTouchInLabel = [tap locationInView:label];
    CGRect textBoundingBox = [layouManager usedRectForTextContainer:textContainer];
    CGPoint textContainerOffset = CGPointMake((label.frame.size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, (label.frame.size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                         locationOfTouchInLabel.y - textContainerOffset.y);
    
    NSUInteger indexOfCharacter = [layouManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    
    return NSLocationInRange(indexOfCharacter, targetRange);
    
}

#pragma mark - getter & setter

static char const kTapKey;
- (void)setTap:(UITapGestureRecognizer *)tap {
    objc_setAssociatedObject(self, &kTapKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer *)tap {
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, &kTapKey);
    return tap;
}

static char const kClickabelTextActionMapKey;

- (void)setClickabelTextActionMap:(NSMutableDictionary *)clickabelTextActionMap {
    objc_setAssociatedObject(self, &kClickabelTextActionMapKey, clickabelTextActionMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)clickabelTextActionMap {
    return objc_getAssociatedObject(self, &kClickabelTextActionMapKey);
}
@end
