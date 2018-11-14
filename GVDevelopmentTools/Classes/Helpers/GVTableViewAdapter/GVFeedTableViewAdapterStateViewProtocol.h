//
//  GVFeedTableViewAdapterStateViewProtocol.h
//  GVTableViewAdapterVersionTwo
//
//  Created by Sangbill on 2018/8/28.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#ifndef GVFeedTableViewAdapterStateViewProtocol_h
#define GVFeedTableViewAdapterStateViewProtocol_h

@class GVFeedTableViewAdapter;

typedef NS_ENUM(NSUInteger, GVFeedTableViewFooterState) {
    GVFeedTableViewFooterStateNormal,
    GVFeedTableViewFooterStateLoadingMore,
    GVFeedTableViewFooterStateEmpty,
    GVFeedTableViewFooterStateEndOfPage,
    GVFeedTableViewFooterStateFailed,
};

@protocol GVFeedTableViewAdapterStateViewDelegate <NSObject>
@required
- (void)emptyDataInTableView:(UITableView *)tableView;
- (void)loadingMoreDataInTableView:(UITableView *)tableView;
- (void)loadMoreDataFailureInTableView:(UITableView *)tableView;
- (void)endOfPageInTableView:(UITableView *)tableView;
- (void)normalStateInTableView:(UITableView *)tableView;
//- (void)stateViewDidTapped:(UITapGestureRecognizer *)tap;
@optional
@end

#endif /* GVFeedTableViewAdapterStateViewProtocol_h */
