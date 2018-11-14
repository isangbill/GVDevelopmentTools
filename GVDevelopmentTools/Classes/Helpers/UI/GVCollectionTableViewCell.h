//
//  GVCollectionTableViewCell.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/9.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVTableViewSection.h"
#import "GVCollectionViewPresenter.h"
#import "GVCollectionViewAdapter.h"
#import "UITableViewCellConfiguration.h"

@protocol GVCollectionTableViewCellLayoutDelegate <NSObject>
@property (nonatomic, assign) CGRect collectionViewFrame;
@end

@protocol GVCollectionTableViewCellDelegate <GVCollectionViewPresenterDelegate, GVCollectionViewAdapterDelegate>
@property (nonatomic, strong) id<GVCollectionTableViewCellLayoutDelegate> layout;
@end

@interface GVCollectionTableViewCell : UITableViewCell <UITableViewCellConfigration>
@property (nonatomic, strong) id<GVCollectionTableViewCellDelegate> row;
@end

