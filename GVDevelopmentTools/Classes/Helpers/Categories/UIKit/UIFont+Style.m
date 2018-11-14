//
//  UIFont+Style.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/11.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIFont+Style.h"

@implementation UIFont (Style)
- (instancetype)gv_fontWithTraits:(UIFontDescriptorSymbolicTraits)traits {
    UIFontDescriptor *descriptor = [self.fontDescriptor fontDescriptorWithSymbolicTraits:traits];
    return [UIFont fontWithDescriptor:descriptor size:0];
}

- (instancetype)gv_bold {
    return [self gv_fontWithTraits:UIFontDescriptorTraitBold];
}

@end
