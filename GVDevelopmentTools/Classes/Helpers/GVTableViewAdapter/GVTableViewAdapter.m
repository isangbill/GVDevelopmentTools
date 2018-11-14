//
//  GVTableViewAdapter.m
//  GVTableViewAdapterVersionTwo
//
//  Created by Sangbill on 2018/8/27.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVTableViewAdapter.h"
#import "UITableViewCellConfiguration.h"

@interface GVTableViewAdapter () <UITableViewDelegate, UITableViewDataSource>
@end
@implementation GVTableViewAdapter 

- (instancetype)initWithViewTableView:(UITableView *)tableView {
    if (!tableView) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _sections = [NSMutableArray array];
        _tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - public methods
- (void)reloadData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionsForTableView:)]) {
        _sections = [self.delegate sectionsForTableView:self.tableView];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GVTableViewSection *section = self.sections[indexPath.section];
    section.index = indexPath.section;
    
    GVTableViewRow *row = section.rows[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:row.cellIdentifier];
    if (!cell) {
        cell = [[row.cellClass alloc] initWithStyle:row.cellStyle reuseIdentifier:row.cellIdentifier];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:configuredCell:withRow:atIndexPath:)]) {
        [self.delegate tableView:tableView configuredCell:cell withRow:row atIndexPath:indexPath];
    }
    
    if ([cell conformsToProtocol:@protocol(UITableViewCellConfigration)]) {
        [(UITableViewCell<UITableViewCellConfigration> *)cell setupRowModel:row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section].rows[indexPath.row].layout.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    
    return nil;
}

#pragma mark - getter & setter
- (void)setDelegate:(id<GVTableViewAdapterDelegate>)delegate {
    _delegate = delegate;
//    if (delegate && [delegate respondsToSelector:@selector(tableViewCellIdentifiterSetForTableView:)]) {
//        NSSet<NSString *> *cellIdentifierSet = [delegate tableViewCellIdentifiterSetForTableView:self.tableView];
//        _cellIdentifierSet = cellIdentifierSet;
//
//        for (NSString *ID in cellIdentifierSet) {
//            [_tableView registerClass:NSClassFromString(ID) forCellReuseIdentifier:ID];
//        }
//    }
    
    if ([delegate respondsToSelector:@selector(sectionsForTableView:)]) {
        _sections = [delegate sectionsForTableView:self.tableView];
    }
}

- (NSSet<NSString *> *)cellIdentifierSet {
    if (!_cellIdentifierSet) {
        _cellIdentifierSet = [NSSet set];
    }
    return _cellIdentifierSet;
}

- (NSMutableArray<GVTableViewSection *> *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
    }
    return _tableView;
}
@end
