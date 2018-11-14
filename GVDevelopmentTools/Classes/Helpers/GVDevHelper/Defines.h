//
//  Defines.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/4.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#ifdef __OBJC__

//#if DEBUG
//#define DebugLog(fmt, ...) NSLog(@"\n$ 文件名: %@ \n""$ 函数名: %s\n""$ 行号: %d  \n$ 打印信息: \n" fmt @"\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else /* DEBUG */
//# define DebugLog(...);
//#endif /* DEBUG */

// 随机颜色
#define GVRandomColor [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]

//设备的width和height
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//iPhone X
#define iPhoneX  (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ||SCREEN_WIDTH == 812.f && SCREEN_HEIGHT == 375.f)

#endif /* __OBJC__ */

#endif /* Defines_h */
