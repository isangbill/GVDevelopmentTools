//
//  GVTableViewSection.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/27.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GVTableViewRow, GVTableViewCellLayout;

@interface GVTableViewSection : NSObject
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray<__kindof GVTableViewRow *> *rows;
@end

@interface GVTableViewRow : NSObject
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, strong) __kindof GVTableViewCellLayout *layout;
@end

@interface GVTableViewCellLayout : NSObject
@property (nonatomic, assign) CGFloat cellHeight;
- (instancetype)initWithRow:(__kindof GVTableViewRow *)row;
@end
