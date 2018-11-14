//
//  NSDictionary+GVExtension.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/7/20.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "NSDictionary+GVExtension.h"
#import <objc/runtime.h>

@implementation NSDictionary (GVExtension)
/// 字符串转字典
+ (NSDictionary *)gv_dictionaryWithString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dict) {
            return dict;
        }
    }
    return nil;
}

//把 NSObject 转为 NSDictionary
+ (NSDictionary *)gv_dictionaryWithObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        Class classObject = NSClassFromString([key capitalizedString]);
        if (classObject) {
            id subObj = [self gv_dictionaryWithObject:[obj valueForKey:key]];
            [dict setObject:subObj forKey:key];
        }
        else
        {
            id value = [obj valueForKey:key];
            if(value) [dict setObject:value forKey:key];
        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)gv_parametersString {
    NSMutableArray* pairs = [NSMutableArray array];
    
    NSArray* keys = [self allKeys];
    
    for (NSString* key in keys) {
        if(![[self objectForKey:key] isKindOfClass:[NSString class]]) {
            continue;
        }
        
        CFStringRef rv = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) [self objectForKey:key], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"), kCFStringEncodingUTF8);
        NSString *copyed = [NSString stringWithString:(__bridge NSString *)rv];
        CFRelease(rv);
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, copyed]];
    }
    return [pairs componentsJoinedByString:@"&"];
    
}

- (NSString *)gv_descriptionStringWithPrettyFormat {
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}
@end
