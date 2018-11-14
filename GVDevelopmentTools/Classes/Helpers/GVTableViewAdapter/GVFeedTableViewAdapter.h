//
//  GVFeedTableViewAdapter.h
//  GVTableViewAdapterVersionTwo
//
//  Created by Sangbill on 2018/8/28.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVTableViewAdapter.h"
#import "GVFeedTableViewAdapterStateViewProtocol.h"

@class GVFeedTableViewAdapter;

@protocol GVTableViewAdapterFetchingDataDelegate <NSObject>
@optional
- (void)feedTableViewAdapter:(GVFeedTableViewAdapter *)adapter refreshDataInTableView:(UITableView *)tableView;

- (void)feedTableViewAdapter:(GVFeedTableViewAdapter *)adapter fetchDataWithPage:(NSInteger)page InTableView:(UITableView *)tableView;
@end


typedef NS_ENUM(NSUInteger, GVFeedTableViewState) {
    GVFeedTableViewStateNormal,
    GVFeedTableViewStateRefreshing,
    GVFeedTableViewStateRefreshFaild,
    GVFeedTableViewStateEmpty,
    GVFeedTableViewStateLoadingMore,
    GVFeedTableViewStateLoadMoreFaild,
    GVFeedTableViewStateEndOfPage
};


@interface GVFeedTableViewAdapter : GVTableViewAdapter
@property (nonatomic, assign) GVFeedTableViewState state;
@property (nonatomic, weak) id<GVTableViewAdapterFetchingDataDelegate> fetcher;
@property (nonatomic, strong) UIView<GVFeedTableViewAdapterStateViewDelegate> *stateFooterView;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger currentPage;

- (void)appendRows:(NSArray<__kindof GVTableViewRow *> *)rows inSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion;

@end
