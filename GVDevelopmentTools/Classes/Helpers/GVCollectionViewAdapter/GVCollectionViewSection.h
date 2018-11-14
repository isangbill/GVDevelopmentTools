//
//  GVCollectionViewSection.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/5.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GVCollectionViewItem, GVCollectionViewCellLayout;

@interface GVCollectionViewSection : NSObject
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSMutableArray<__kindof GVCollectionViewItem *> *items;
@end


@interface GVCollectionViewItem : NSObject
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) __kindof GVCollectionViewCellLayout *layout;
@end

@interface GVCollectionViewCellLayout : NSObject
- (instancetype)initWithItem:(__kindof GVCollectionViewItem *)item;
@end



