//
//  NSString+GVExtension.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/20.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (GVExtension)

/**
 判断字符串是否为一个合法的电子邮箱
 
 @return  YES 为合法，NO 为不合法
 */
- (BOOL)gv_isValidEmail;

/**
 判断字符串是否为空
 
 @return  YES 为空，NO 反之
 */
- (BOOL)gv_isEmpty;

/**
 判断是否包含某个子字符串
 
 @param string 是否被包含的字符串
 @return YES 为包含，NO 不包含
 */
- (BOOL)gv_includesString:(NSString *)string;

/**
 去掉头尾的空白字符串
 
 @return 去掉头尾的空白后的字符串
 */
- (NSString *)gv_trim;

/**
 去掉整段文字内的所有空白字符（包括换行符）
 
 @return 去掉整段文字内的所有空白字符后的字符串
 */
- (NSString *)gv_trimAllWhiteSpace;

/**
 将文字中的换行符替换为空格
 
 @return 换行符替换为空格后的字符串
 */
- (NSString *)gv_trimLineBreakCharacter;

/**
 把某个十进制数字转换成十六进制的数字的字符串，例如“10”->“A”
 
 @param integer 十进制数字
 @return 十六进制对应的字符
 */
+ (NSString *)gv_hexStringWithInteger:(NSInteger)integer;

/**
 base 64 加密
 
 @return base 64 后的字符串
 */
- (NSString *)gv_base64EncodedString;

/**
 base 64 解密
 
 @return base 64 解密后的字符串
 */
- (NSString *)gv_base64DecodedString;

/**
 MD5 加密

 @return  MD5加密字符串
 */
- (NSString *)gv_MD5String;

/**
 获取当前时间戳字符串

 @return 当前时间戳字符串
 */
+ (NSString *)gv_stringFromTimestamp;

/**
根据 bool 生成字符串, 返回 YES 或者 NO

 @param flag bool 值
 @return flag 为真 返回 YES 反之 NO
 */
+ (NSString *)gv_stringFromBool:(BOOL)flag;

/**
 *  计算文本大小
 *
 *  @param font 字体
 *  @param size 约束大小
 */
- (CGSize)gv_boundingSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  指定字体下, 字符串的宽度, 行数为 1
 *
 *  @param font 字体
 *
 *  @return 字符串的长度
 */
- (CGFloat)gv_widthWithFont:(UIFont *)font;

/**
 *  指定宽度和字体下, 计算字符串的高度
 *
 *  @param font  指定的字体
 *  @param width 指定的宽度
 *
 *  @return 字符串的高度
 */
- (CGFloat)gv_heightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  根据长度随机生成字符串 (由英文和数字组成)
 *
 *  @param length 字符串长度
 *
 *  @return 根据长度随机生成由英文和数字组成的字符串
 */
+ (NSString *)gv_randomStringWithLength:(NSUInteger)length;

/**
 根据指定范围内随机生成随机长度的字符串 (由英文和数字组成)

 @param from 范围左区间
 @param to 范围右区间
 @return 生成的字符串
 */
+ (NSString *)gv_randomStringWithRandomLengthBetween:(NSUInteger)from to:(NSUInteger)to;

/**
 *  返回一个文件全路径 (以调用者为文件名,  沙盒的 document 文件夹为父路径)
 *
 *  @return 一个文件全路径 (以调用者为文件名,  沙盒的 document 文件夹为父路径)
 */
- (NSString *)gv_pathWithDocumentDirectory;

/**
 *  返回一个文件全路径 (以调用者为文件名,  沙盒的 library 文件夹为父路径)
 *
 *  @return 一个全文件路径 (以调用者为文件名,  沙盒的 library 文件夹为父路径)
 */
- (NSString *)gv_pathWithLibraryDirectory;

/**
 *  返回一个文件全路径 (以调用者为文件名,  沙盒的 library/cache 文件夹为父路径)
 *
 *  @return 一个文件全路径 (以调用者为文件名,  沙盒的 library/cache 文件夹为父路径)
 */
- (NSString *)gv_pathWithCacheDirectory;

/**
 <#Description#>

 @param uploadDateString <#dateString description#>
 @return <#return value description#>
 */
+ (NSString *)gv_elapsedTimeStringSinceDate:(NSString *)uploadDateString;
@end
