//
//  NSDictionary+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/20.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GVExtension)
/// 字符串转字典
+ (NSDictionary *)gv_dictionaryWithString:(NSString *)string;

/// 对象转字典 (属性是 key, 属性的值为 values)
+ (NSDictionary *)gv_dictionaryWithObject:(id)obj;

/**
 *  根据字典的键值对生成参数字符串 (参数之间用 & 连接)
 *
 *  @return 根据字典的键值对生成的参数字符串
 */
- (NSString *)gv_parametersString;
/**
 *  将字典转化为格式好看的字符串 (方便打印调试)
 *
 *  @return 字典的描述字符串
 */
- (NSString *)gv_descriptionStringWithPrettyFormat;
@end
