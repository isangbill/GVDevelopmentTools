//
//  UILabel+Clickable.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/11.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Clickable)
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) NSMutableDictionary *clickabelTextActionMap;

- (void)gv_addClickableRange:(NSRange)clickableRange withUnderline:(BOOL)underline highlightedColor:(UIColor *)highlightedColor actionBlock:(void(^)(void))actionBlock;
@end
