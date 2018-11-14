//
//  GVLog.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/12.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#ifndef GVLog_h
#define GVLog_h

#ifdef __OBJC__
#import "DDLog.h"
#import "CocoaLumberjack.h"

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#define logBody (@"\n$  文件名: %@ \n""$  函数名: %s\n""$   行号: %d  \n$ 打印信息: \n" fmt @"\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__)

#define DebugLog(fmt, ...) DDLogVerbose(@"\n$  文件名: %@ \n""$  函数名: %s\n""$   行号: %d  \n$ 打印信息: \n" fmt @"\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define GVLogError(fmt, ...) DDLogError(@"\n$  文件名: %@ \n""$  函数名: %s\n""$   行号: %d  \n$ 打印信息: \n" fmt @"\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define GVLogWarn(fmt, ...) DDLogWarn(@"\n$  文件名: %@ \n""$  函数名: %s\n""$   行号: %d  \n$ 打印信息: \n" fmt @"\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define GVLogInfo(fmt, ...) DDLogInfo(@"\n$  文件名: %@ \n""$  函数名: %s\n""$   行号: %d  \n$ 打印信息: \n" fmt @"\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define GVLogDebug(fmt, ...) DDLogDebug(@"\n$  文件名: %@ \n""$  函数名: %s\n""$    行号: %d  \n$ 打印信息: \n" fmt @"\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ##__VA_ARGS__)


#else /* DEBUG */

static const int ddLogLevel = DDLogLevelOff;
#define DebugLog(fmt, ...)
#define GVLogError(fmt, ...)
#define GVLogWarn(fmt, ...)
#define GVLogInfo(fmt, ...)
#define GVLogDebug(fmt, ...)

#endif /* DEBUG */


#endif /* GVLog_h */
#endif /* __OBJC__*/
