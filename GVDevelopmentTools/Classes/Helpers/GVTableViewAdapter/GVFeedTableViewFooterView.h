//
//  GVFeedTableViewFooterView.h
//  GVTableViewAdapterVersionTwo
//
//  Created by Sangbill on 2018/8/28.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVFeedTableViewAdapterStateViewProtocol.h"

@interface GVFeedTableViewFooterView : UIView <GVFeedTableViewAdapterStateViewDelegate> {
    UIActivityIndicatorView *_activityIndicator;
    UILabel *_infoLabel;
    UIView *_containerView;
    UIImageView *_iconImageView;
}

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong, readonly) UILabel *infoLabel;
@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign) GVFeedTableViewFooterState state;
@end
