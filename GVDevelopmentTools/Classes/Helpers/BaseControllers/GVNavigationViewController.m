//
//  GVNavigationViewController.m
//  GVDevelopHelper
//
//  Created by Sangbill on 2018/9/3.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVNavigationViewController.h"
#import "UIImage+Shape.h"

@interface GVNavigationViewController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
/**
 是否允许右滑返回
 */
@property (nonatomic, assign, getter=isBackGestureEnable) BOOL backGestureEnable;

@end

@implementation GVNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    //设置全局右滑返回
//    [self setupRightPanReturn];
    
    [self.navigationItem setHidesBackButton:YES];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---每次push之后生成返回按钮----
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        UIImage *backImage = [UIImage imageWithShape:GVImageShapeNavBack size:CGSizeMake(13, 23) tintColor:[UIColor redColor]];
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];

        viewController.hidesBottomBarWhenPushed = YES;
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // push的时候禁用手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
        self.backGestureEnable = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    for (UIViewController *viewController in viewControllers) {
        if (viewController != [viewControllers firstObject]) {
            UIImage *backImage = [UIImage imageWithShape:GVImageShapeNavBack size:CGSizeMake(13, 23) tintColor:[UIColor redColor]];
            backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
            
            viewController.hidesBottomBarWhenPushed = YES;
            viewController.edgesForExtendedLayout = UIRectEdgeNone;
            viewController.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    // push的时候禁用手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
        self.backGestureEnable = NO;
    }
    
    [super setViewControllers:viewControllers animated:animated];
}


- (void)popViewController{
    [self popViewControllerAnimated:YES];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    // pop的时候禁用手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (self.backGestureEnable) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    return [super popViewControllerAnimated:animated];
}


- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    
    // pop的时候禁用手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToRootViewControllerAnimated:animated];
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // push完成后的时候判断是否在根控制器启用手势
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        if ([navigationController.viewControllers count] == 1) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        } else {
//            self.backGestureEnable = YES;
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

#pragma mark ---处理全局右滑返回---
- (void)setupRightPanReturn{
    
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 获取返回方法
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    NSLog(@"%@", targetView);
    //  创建pan手势 作用范围是全屏
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
    pan.delegate = self;
    [targetView addGestureRecognizer:pan];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
    
}

// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    
    //解决与左滑手势冲突
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0 || !self.isBackGestureEnable) {
        return NO;
    }
    return self.childViewControllers.count == 1 ? NO : YES;
}

@end
