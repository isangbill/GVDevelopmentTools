//
//  GVPermissonManager.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/17.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface GVPermissonManager : NSObject
+ (void)getCameraPermissonWithMediaType:(AVMediaType)mediaType Completion:(void(^)(BOOL granted, AVAuthorizationStatus status))completion;
+ (void)registerRemoteNotification;
@end
