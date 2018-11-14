//
//  GVAlertor.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/7.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVAlertor.h"
#import "GVLanguageManager.h"
#import "NSString+GVExtension.h"
@implementation GVAlertor

+ (void)presentAlertWithMessage:(NSString *)message {
    [self presentAlertWithTitle:GVLocalizedStringForKey(@"alert.title.info") message:message completionBlock:nil];
}

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message {
    [self presentAlertWithTitle:title message:message completionBlock:nil];
}

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message completionBlock:(void (^)(bool okButtonPressed))completionBlock {
    [self presentAlertWithTitle:title message:message cancelButtonTitle:nil okButtonTitle:GVLocalizedStringForKey(@"alert.title.ok") completionBlock:completionBlock];
}

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle completionBlock:(void (^)(bool okButtonPressed))completionBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title.length == 0 ? nil : title message:message preferredStyle:UIAlertControllerStyleAlert];
        
    if (title != nil && message.length != 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.lineSpacing = 2.0f;
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0], NSParagraphStyleAttributeName: paragraphStyle}];
        [alertController setValue:attributedString forKey:@"attributedMessage"];
    }
    
    if (okButtonTitle != nil) {
        UIAlertAction* ok = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction * _Nonnull action) {
            if (completionBlock) {
                completionBlock(true);
            }
        }];
        [alertController addAction:ok];
    }
    
    if     (cancelButtonTitle != nil) {
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction * _Nonnull action) {
            if (completionBlock) {
                completionBlock(false);
            }
        }];
        [alertController addAction:cancel];
    }
    
    UIWindow *targetWindow = [UIApplication sharedApplication].delegate.window;
    
    for (UIWindow *window in [UIApplication sharedApplication].windows.reverseObjectEnumerator) {
        if (window.rootViewController != nil && ([NSStringFromClass([window class]) hasPrefix:@"UITextEffec"] || [NSStringFromClass([window class]) hasPrefix:@"UIRemoteKe"])) {
            targetWindow = window;
            break;
        }
    }

    UIViewController *controller = targetWindow.rootViewController;
    if (controller.view.window == nil && controller.presentedViewController != nil) {
        controller = controller.presentedViewController;
    }
    [controller presentViewController:alertController animated:true completion:nil];
}
@end
