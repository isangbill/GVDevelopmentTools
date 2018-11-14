//
//  GVCollectionViewSection.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/5.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVCollectionViewSection.h"

@implementation GVCollectionViewSection
- (NSMutableArray<GVCollectionViewItem *> *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
@end

@implementation GVCollectionViewItem
- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellIdentifier = NSStringFromClass([UICollectionViewCell class]);
    }
    return self;
}
@end

@implementation GVCollectionViewCellLayout
- (instancetype)initWithItem:(__kindof GVCollectionViewItem *)item {
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
