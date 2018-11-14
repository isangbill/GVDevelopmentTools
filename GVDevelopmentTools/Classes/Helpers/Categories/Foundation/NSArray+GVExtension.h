//
//  NSArray+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/20.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GVExtension)
/**
 *  讲数组转换成格式美观的字符串, 方便打印调试
 *
 *  @return 数组的描述
 */
- (NSString *)gv_descriptionStringWithPrettyFormat;
/**
 *  检查数组是否为空
 *
 *  @return YES 表示数组为空, NO 反之
 */
- (BOOL)gv_isEmpty;

/**
 *  过滤数组元素，将 block 返回 YES 的 item 重新组装成一个数组返回
 */
- (instancetype)gv_filterWithBlock:(BOOL (^)(id item))block;
@end
