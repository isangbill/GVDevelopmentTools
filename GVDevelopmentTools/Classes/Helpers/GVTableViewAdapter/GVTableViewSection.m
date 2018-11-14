//
//  GVTableViewSection.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/27.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import "GVTableViewSection.h"

@implementation GVTableViewSection
- (NSMutableArray<GVTableViewRow *> *)rows {
    if (!_rows) {
        _rows = [NSMutableArray array];
    }
    return _rows;
}

@end

@implementation GVTableViewRow
- (instancetype)init {
    self = [super init];
    if (self) {
        self.layout = [GVTableViewCellLayout new];
        self.cellIdentifier = @"UITableViewCell";
        self.cellStyle = UITableViewCellStyleDefault;
    }
    return self;
}
@end

@implementation GVTableViewCellLayout
- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellHeight = 44.f;
    }
    return self;
}

- (instancetype)initWithRow:(__kindof GVTableViewRow *)row {
    self = [super init];
    if (self) {
        self.cellHeight = 44.f;
    }
    return self;
}
@end
