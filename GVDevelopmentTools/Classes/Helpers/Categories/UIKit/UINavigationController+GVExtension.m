//
//  UINavigationController+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/23.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "UINavigationController+GVExtension.h"
#import "UIViewController+NavigaitonBarBackItemSupport.h"
#import "UIImage+Shape.h"
#import <objc/runtime.h>

@implementation UINavigationController (GVExtension)
@dynamic gv_rootViewController;

/**
 *  如果 fromClass 里存在 originSelector，则这个函数会将 fromClass 里的 originSelector 与 toClass 里的 newSelector 交换实现。
 *  如果 fromClass 里不存在 originSelecotr，则这个函数会为 fromClass 增加方法 originSelector，并且该方法会使用 toClass 的 newSelector 方法的实现，而 toClass 的 newSelector 方法的实现则会被替换为空内容
 *  @warning 注意如果 fromClass 里的 originSelector 是继承自父类并且 fromClass 也没有重写这个方法，这会导致实际上被替换的是父类，然后父类及父类的所有子类（也即 fromClass 的兄弟类）也受影响，因此使用时请谨记这一点。
 *  @param _fromClass 要被替换的 class，不能为空
 *  @param _originSelector 要被替换的 class 的 selector，可为空，为空则相当于为 fromClass 新增这个方法
 *  @param _toClass 要拿这个 class 的方法来替换
 *  @param _newSelector 要拿 toClass 里的这个方法来替换 originSelector
 *  @return 是否成功替换（或增加）
 */
CG_INLINE BOOL
ExchangeImplementationsInTwoClasses(Class _fromClass, SEL _originSelector, Class _toClass, SEL _newSelector) {
    if (!_fromClass || !_toClass) {
        return NO;
    }
    
    Method oriMethod = class_getInstanceMethod(_fromClass, _originSelector);
    Method newMethod = class_getInstanceMethod(_toClass, _newSelector);
    if (!newMethod) {
        return NO;
    }
    
    BOOL isAddedMethod = class_addMethod(_fromClass, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        // 如果 class_addMethod 成功了，说明之前 fromClass 里并不存在 originSelector，所以要用一个空的方法代替它，以避免 class_replaceMethod 后，后续 toClass 的这个方法被调用时可能会 crash
        IMP oriMethodIMP = method_getImplementation(oriMethod) ?: imp_implementationWithBlock(^(id selfObject) {});
        const char *oriMethodTypeEncoding = method_getTypeEncoding(oriMethod) ?: "v@:";
        class_replaceMethod(_toClass, _newSelector, oriMethodIMP, oriMethodTypeEncoding);
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}

/// 交换同一个 class 里的 originSelector 和 newSelector 的实现，如果原本不存在 originSelector，则相当于给 class 新增一个叫做 originSelector 的方法
CG_INLINE BOOL
ExchangeImplementations(Class _class, SEL _originSelector, SEL _newSelector) {
    return ExchangeImplementationsInTwoClasses(_class, _originSelector, _class, _newSelector);
}


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(viewDidLoad), @selector(gv_viewDidLoad));
        ExchangeImplementations([self class], @selector(pushViewController:animated:), @selector(gv_pushViewController:animated:));
    });
}

- (void)gv_viewDidLoad {
    [self gv_viewDidLoad];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    //设置全局右滑返回
    //    [self setupRightPanReturn];
    
    [self.navigationItem setHidesBackButton:YES];
    self.delegate = self;
    
    if (self.interactivePopGestureRecognizer.delegate) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

- (UIViewController *)gv_rootViewController {
    return self.viewControllers.firstObject;
}

#pragma mark - push
- (void)gv_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        UIImage *backImage = [UIImage imageWithShape:GVImageShapeNavBack size:CGSizeMake(13, 23) tintColor:[UIColor redColor]];
//        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        viewController.automaticallyAdjustsScrollViewInsets = NO;
        
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
        }
        
    }
    
    // push的时候禁用手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self gv_pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // push完成后的时候判断是否在根控制器启用手势
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {

        if ([navigationController.viewControllers count] == 1) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        } else {
            //            self.backGestureEnable = YES;
            if ([self.topViewController respondsToSelector:@selector(interactivePopGestureRecognizerEnable)]) {
                navigationController.interactivePopGestureRecognizer.enabled = [self.topViewController interactivePopGestureRecognizerEnable];
            } else {
                navigationController.interactivePopGestureRecognizer.enabled = YES;
            }
        }
    }
}

#pragma mark - pop
- (void)popViewController {
    if ([self.topViewController respondsToSelector:@selector(shouldHoldBackButtonEvent)]) {
        if ([self.topViewController shouldHoldBackButtonEvent]) {
            if ([self.topViewController respondsToSelector:@selector(canPopViewController)]) {
                BOOL canPopViewController = [self.topViewController canPopViewController];
                if (canPopViewController) {
                    [self popViewControllerAnimated:YES];
                }
            }
        }
    } else {
        [self popViewControllerAnimated:YES];        
    }
}
@end
