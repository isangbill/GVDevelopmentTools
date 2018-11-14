//
//  GVProgressHUD.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/14.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVProgressHUD.h"
#import "MBProgressHUD.h"

@interface GVProgressHUD ()
@property (nonatomic, strong) MBProgressHUD *mainHUD;
@end

@implementation GVProgressHUD
+ (instancetype)showInView:(UIView *)view {
    return [self showInView:view animated:YES];
}

+ (instancetype)showInView:(UIView *)view animated:(BOOL)animated {
    return [self showInView:view withInfo:nil animated:animated];
}

+ (instancetype)showInView:(UIView *)view withInfo:(NSString *)info animated:(BOOL)animated {
    GVProgressHUD *hud = [GVProgressHUD new];
    hud.mainHUD = [MBProgressHUD showHUDAddedTo:view animated:animated];
    if (info) {
        hud.mainHUD.label.text = info;
    }
    return hud;
}

+ (void)popForView:(UIView *)view animated:(BOOL)animated {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void)hide {
    [self.mainHUD hideAnimated:YES];
}

@end
