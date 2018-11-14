//
//  GVLanguageManager.m
//  GVDevelopHelper
//
//  Created by Sangbill on 2018/9/3.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVLanguageManager.h"

static NSString *const kAppCurrentLangugae = @"appCurrentLanguage";
NSString *const GVLanguageManagerDidChangeAppLanguageNotification = @"GVLanguageManagerDidChangeAppLanguageNotification";

@implementation GVLanguageManager {
    NSArray<NSString *> *_preferredLanguagesRaw;
    NSArray<NSString *> *_languageTitles;
}
static GVLanguageManager *_manager;
#pragma mark - public methods
NSString *GVLocalizedStringForKeyInTable(NSString *key, NSString *table) {
    return [[GVLanguageManager sharedManager] localStringForKey:key withTable:table];
}

NSString *GVLocalizedStringForKey(NSString *key) {
    return GVLocalizedStringForKeyInTable(key, nil);
}

- (NSString *)localStringForKey:(NSString *)key withTable:(NSString *)table {
    if ([key isKindOfClass:[NSNull class]] || [key isEqualToString:@"<null>"]) {
        return @"string-null";
    }
    
    return NSLocalizedStringFromTableInBundle(key, table, self.currentLanguageBundle, @"");
}

- (void)changeLanguageTo:(GVAppLanguageTpye)newLanguage {
    NSString *nl = _preferredLanguagesRaw[newLanguage];
    if ([nl isEqualToString:_appCurrentLanguage]) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        if (![def valueForKey:kAppCurrentLangugae]) {
            [def setValue:_appCurrentLanguage forKey:kAppCurrentLangugae];
            [def synchronize];
        }
        return;
    }
    
    [self _saveAppCurrentLanguage:nl];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:nl ofType:@"lproj"];
    self.currentLanguageBundle = [NSBundle bundleWithPath:path];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:GVLanguageManagerDidChangeAppLanguageNotification object:nil];
}

#pragma mark - private methods
-(void)_saveAppCurrentLanguage:(NSString *)appCurrentLanguage{
    if (!appCurrentLanguage || (appCurrentLanguage == _appCurrentLanguage)) {
        return;
    }
    
    self.appCurrentLanguage = appCurrentLanguage;
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:appCurrentLanguage forKey:kAppCurrentLangugae];
    [def synchronize];
}

#pragma mark - getter & setter
- (NSBundle *)currentLanguageBundle {
    if (!_currentLanguageBundle) {
        NSString *path = [[NSBundle mainBundle]pathForResource:self.appCurrentLanguage ofType:@"lproj"];
        _currentLanguageBundle = [NSBundle bundleWithPath:path];
    }
    return _currentLanguageBundle;
}

- (NSString *)appCurrentLanguage {
    if (!_appCurrentLanguage) {
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *userLanguage = [def valueForKey:kAppCurrentLangugae];
        if (!userLanguage) { // 获取本机设置的语言
            
#if TARGET_IPHONE_SIMULATOR
            NSLog(@"run on simulator");
            NSString *identifier = [[NSLocale currentLocale] localeIdentifier];
            if ([identifier containsString:@"_"]) {
                NSMutableArray *langAndRegion = [NSMutableArray arrayWithArray:[identifier componentsSeparatedByString:@"_"]];
                userLanguage = langAndRegion.firstObject;
            } else {
                NSLocale *currentLocale = [NSLocale currentLocale];
                userLanguage = [currentLocale objectForKey:NSLocaleLanguageCode];
            }
#else
            NSString *fullString = [[NSLocale preferredLanguages] firstObject];
            NSMutableArray *langAndRegion = [fullString componentsSeparatedByString:@"-"].mutableCopy;
            [langAndRegion removeLastObject];
            
            userLanguage = langAndRegion.firstObject;
            if (langAndRegion.count >= 2) {
                userLanguage = [langAndRegion componentsJoinedByString:@"-"];
            }
#endif
            
        }
        
        _appCurrentLanguage = [_preferredLanguagesRaw containsObject:userLanguage] ? userLanguage : _preferredLanguagesRaw.firstObject;
    }
    return _appCurrentLanguage;
    
}
#pragma mark - singleton

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _preferredLanguagesRaw = @[@"en", @"zh-Hans", @"ms"];
        _languageTitles = @[@"English", @"中文（简体）", @"Malaysia"];
    }
    return self;
}
@end
