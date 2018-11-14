//
//  GVLanguageManager.h
//  GVDevelopHelper
//
//  Created by Sangbill on 2018/9/3.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define GVLocalStringForKey(key, table) [[GVLanguageManager sharedManager] localStringForKey:key withTable:table]
#define LanguageManager [GVLanguageManager sharedManager]

extern NSString * const GVLanguageManagerDidChangeAppLanguageNotification;

typedef NS_ENUM(NSUInteger, GVAppLanguageTpye){
    GVAppLanguageTypeEN,
    GVAppLanguageTypeZH_Hans,
    GVAppLanguageTypeMS
};


@interface GVLanguageManager : NSObject
@property(nonatomic,strong) NSBundle *currentLanguageBundle;
@property(nonatomic,copy) NSString *appCurrentLanguage;
@property (nonatomic, strong) NSString *systemCurrentLanguage;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)sharedManager;

NSString *GVLocalizedStringForKeyInTable(NSString *key, NSString *table);
NSString *GVLocalizedStringForKey(NSString *key);

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
-(NSString *)localStringForKey:(NSString *)key withTable:(NSString *)table;

/**
 *  改变当前语言
 */
-(void)changeLanguageTo:(GVAppLanguageTpye)newLanguage;
//- (void)changeToLanguage:(NSString *)language; //改变为对应的语言 传入字符串

@end
