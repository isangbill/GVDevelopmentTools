//
//  UIViewController+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UIViewController+GVExtension.h"

@implementation UIViewController (GVExtension)
@dynamic gv_previousViewController;
@dynamic gv_previousViewControllerTitle;

- (UIViewController *)gv_previousViewController {
    if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 1 && self.navigationController.topViewController == self) {
        NSUInteger count = self.navigationController.viewControllers.count;
        return (UIViewController *)[self.navigationController.viewControllers objectAtIndex:count - 2];
    }
    return nil;
}

- (NSString *)gv_previousViewControllerTitle {
    UIViewController *previousViewController = [self gv_previousViewController];
    if (previousViewController) {
        return previousViewController.title;
    }
    return nil;
}

- (void)setupNavigationBarTitleViewImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imageView;
}

- (void)setupNavigationBarLeftBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

- (void)setupNavigationBarRightBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}
@end
