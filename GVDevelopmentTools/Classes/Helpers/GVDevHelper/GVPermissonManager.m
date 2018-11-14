//
//  GVPermissonManager.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/17.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import "GVPermissonManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <UserNotifications/UserNotifications.h>
#import "GVLog.h"

@implementation GVPermissonManager
+ (void)getCameraPermissonWithMediaType:(AVMediaType)mediaType Completion:(void(^)(BOOL granted, AVAuthorizationStatus status))completion {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    switch (authStatus) {
            //1.未决定
        case AVAuthorizationStatusNotDetermined: {
            //2.申请权限
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if (completion) {
                    if (granted) {
                        completion(YES, AVAuthorizationStatusAuthorized);
                    }
                }
            }];
            
            break;
        }
            //3.授权失败
        case AVAuthorizationStatusDenied:
            completion(NO, AVAuthorizationStatusDenied);
            break;
            //4.成功授权
        case AVAuthorizationStatusAuthorized:
            completion(YES, AVAuthorizationStatusAuthorized);
            break;
        default:
            break;
    }
}

+ (void)registerRemoteNotification {
    [self registerLocalNotification];
    // 获取DeviceToken:将UDID(真机)和BundleID发送到APNs服务器,来获取DeviceToken
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

+ (void)registerLocalNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        [notificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                DebugLog(@"request authorization succeeded!");
            }
        }];
    } else if (@available(iOS 8.0, *)) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

- (void)_configLogger {
    
}
@end
