//
//  GVDevHelper.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/26.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GVDevHelper : NSObject
/**
 *  获取时间戳
 *
 *  @return 当前时间戳
 */
+ (NSTimeInterval)timestamp;

/**
 *  获取时间戳 String
 *
 *  @return 当前时间戳的 String
 */
+ (NSString *)timestampString;

/**
 *  显示网络指示器
 */
+ (void)showNetworkActivityIndicator;

/**
 *  隐藏网络指示器
 */
+ (void)hideNetworkActivityIndicator;
/**
 *  获取主窗口的键盘第一响应者
 *
 *  @return 键盘的第一响应者
 */
+ (UIView *)firstResponder;
/**
 *  生成随机整数
 *
 *  @param from 从该整数开始
 *  @param to   到该整数之前
 *
 *  @return 随机的整数
 */
+ (int)randomIntegerBetween:(int)from to:(int)to;

/**
 *  生成随机浮点数
 *
 *  @param from 从该浮点数开始
 *  @param to   到该浮点数之前
 *
 *  @return 随机的浮点数
 */
+ (float)randomFloatBetween:(float)from to:(float)to;

/**
 *  生成随机 double
 *
 *  @param from 从该 double开始
 *  @param to   到该 double之前
 *
 *  @return 随机的 double
 */
+ (double)randomDoubleBetween:(double)from to:(double)to;
/**
 *  生成随机布尔值
 *
 *  @return 随机布尔值
 */
+ (BOOL)randomBool;
/**
 *  获取指定范围内, 随机数量的随机字符串
 *
 *  @param from 下限数量
 *  @param to   上限数量
 *
 *  @return 随机字符串
 */
+ (NSString *)randomStringWithRandomLengthBetween:(NSUInteger)from to:(NSUInteger)to;

/**
 *  根据指定宽度缩放面积
 *
 *  @param fitWidth   指定 width
 *  @param originSize 需要缩放的 size
 *
 *  @return 缩放后的 size
 */
+ (CGSize)fitSizeWithWidth:(CGFloat)fitWidth originSize:(CGSize)originSize;

/**
 *  指定路径的文件/文件夹大小
 *
 *  @param path 需要计算的路径
 *
 *  @return 文件/文件夹的大小
 */
+ (unsigned long long)fileSizeWithPath:(NSString *)path;

/**
 * 把App的主要window置灰，用于浮层弹出时，请注意要在适当时机调用`resetDimmedApplicationWindow`恢复到正常状态
 */
+ (void)dimmedApplicationWindow;

/**
 * 恢复对App的主要window的置灰操作，与`dimmedApplicationWindow`成对调用
 */
+ (void)resetDimmedApplicationWindow;

/// 获取一个像素的大小 (CGFloat)
+ (CGFloat)pixelOne;

/**
 *  获取设备的唯一标识
 *
 *  @return 设备的唯一标识
 */
+ (NSString *)getDeviceUUID;

NSString * callerInfo(void);

@end


/// 本地及远程通知相关
@interface GVDevHelper (Notification)
+ (void)registerNotification;
@end
