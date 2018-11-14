//
//  GVFeedTableViewAdapter.m
//  GVTableViewAdapterVersionTwo
//
//  Created by Sangbill on 2018/8/28.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVFeedTableViewAdapter.h"
#import "GVFeedTableViewFooterView.h"
#import "UITableViewCellConfiguration.h"

@interface GVFeedTableViewAdapter ()
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation GVFeedTableViewAdapter {
    
}

#pragma mark - life cycle
- (instancetype)initWithViewTableView:(UITableView *)tableView {
    self = [super initWithViewTableView:tableView];
    if (self) {
        self.currentPage = 1;
        self.totalPage = 1;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.tableView addSubview:self.refreshControl];
        self.state = GVFeedTableViewStateNormal;
        [self.tableView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - private methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.state = self.state;
}

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"frame"];
}

#pragma mark - public methods
- (void)reloadData {
    _sections = [self.delegate sectionsForTableView:self.tableView];
    
    BOOL isEmpty = YES;
    for (GVTableViewSection *section in self.sections) {
        if (section.rows.count) {
            isEmpty = NO;
            break;
        }
    }
   
    if (isEmpty) {
        self.state = GVFeedTableViewStateEmpty;
    } else {
        self.state = GVFeedTableViewStateLoadingMore;
    }
    
    self.currentPage = 1;
    [self.tableView reloadData];
    
    if ([_refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
    
}

- (void)appendRows:(NSArray<__kindof GVTableViewRow *> *)rows inSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion {
    if (!rows.count || !rows) {
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
        return;
    }
    
    if (section > (self.sections.count - 1)) {
        NSString *desc = [NSString stringWithFormat:@"无法添加行到第 %ld 组，因为只有 %lu 组", (long)section, (unsigned long)self.sections.count];
        NSAssert((section <= self.sections.count - 1), desc);
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
        return;
    }
    
    GVTableViewSection *sec = self.sections[section];
    
    NSInteger oldRowsCount = sec.rows.count;
    [sec.rows addObjectsFromArray:rows];
    
    NSMutableArray<NSIndexPath *> *addingIndexPaths = [NSMutableArray array];
    
    for (NSInteger i = 0; i < rows.count; i++) {
        NSIndexPath *addingIndexPath = [NSIndexPath indexPathForRow:(oldRowsCount + i) inSection:section];
        [addingIndexPaths addObject:addingIndexPath];
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:addingIndexPaths.copy withRowAnimation:animation];
        [self.tableView endUpdates];
        if (completion) {
            completion();
        }
    });
    
    
}
#pragma mark - actions
- (void)_refreshAction {
    if (self.fetcher && [self.fetcher respondsToSelector:@selector(feedTableViewAdapter:refreshDataInTableView:)]) {
        if (GVFeedTableViewStateRefreshing == self.state) {
            return;
        }
        
        self.state = GVFeedTableViewStateRefreshing;
        [self.fetcher feedTableViewAdapter:self refreshDataInTableView:self.tableView];
    }
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == (self.sections.count - 1) && indexPath.row == (self.sections.lastObject.rows.count - 1)) {
        if (self.currentPage < self.totalPage) {
            self.state = GVFeedTableViewStateLoadingMore;
            if (self.fetcher && [self.fetcher respondsToSelector:@selector(feedTableViewAdapter:fetchDataWithPage:InTableView:)]) {
                [self.fetcher feedTableViewAdapter:self fetchDataWithPage:_currentPage InTableView:tableView];
            }
        } else {
            self.state = GVFeedTableViewStateEndOfPage;
        }
    }
    
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
   
    if ([cell conformsToProtocol:@protocol(UITableViewCellConfigration)] && [cell respondsToSelector:@selector(setupRowModel:)]) {
        [(UITableViewCell<UITableViewCellConfigration> *)cell setupRowModel:row];
    }
    
    return cell;
}

#pragma mark - getter & setter
- (void)setFetcher:(id<GVTableViewAdapterFetchingDataDelegate>)fetcher {
    _fetcher = fetcher;
    self.tableView.tableFooterView = self.stateFooterView;
    if (!self.refreshControl.superview || ![self.refreshControl.superview isEqual:self.tableView]) {
        [self.tableView addSubview:self.refreshControl];        
    }
}

- (UIView<GVFeedTableViewAdapterStateViewDelegate> *)stateFooterView {
    if (!_stateFooterView) {
        _stateFooterView = [GVFeedTableViewFooterView new];
        _stateFooterView.frame = CGRectMake(0, 0, 0, 44.f);
    }
    return _stateFooterView;
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [UIRefreshControl new];
        [_refreshControl addTarget:self action:@selector(_refreshAction) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (void)setState:(GVFeedTableViewState)state {
    _state = state;
    switch (state) {
        case GVFeedTableViewStateNormal:
            if ([_refreshControl isRefreshing]) {
                [self.refreshControl endRefreshing];
            }
            [self.stateFooterView normalStateInTableView:self.tableView];
            break;
        case GVFeedTableViewStateRefreshing:
            
            break;
        case GVFeedTableViewStateRefreshFaild:
            
            break;
        case GVFeedTableViewStateEmpty:
            [self.stateFooterView emptyDataInTableView:self.tableView];
            break;
        case GVFeedTableViewStateLoadingMore: 
            [self.stateFooterView loadingMoreDataInTableView:self.tableView];
            break;
        case GVFeedTableViewStateLoadMoreFaild:
            [self.stateFooterView loadMoreDataFailureInTableView:self.tableView];
            break;
        case GVFeedTableViewStateEndOfPage:
            [self.stateFooterView endOfPageInTableView:self.tableView];
            break;
    }
}

@end
