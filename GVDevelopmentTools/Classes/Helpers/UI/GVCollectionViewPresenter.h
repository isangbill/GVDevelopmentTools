//
//  GVCollectionViewPresenter.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/9.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GVCollectionViewPresenter, GVCollectionViewAdapter, GVCollectionViewSection;

@protocol GVCollectionViewPresenterDelegate <NSObject>
- (UICollectionViewFlowLayout *)collectionViewLayoutForCollectionViewPresenter:(GVCollectionViewPresenter *)collectionViewPresenter;
@end

@interface GVCollectionViewPresenter : NSObject {
    UICollectionView *_collectionView;
    GVCollectionViewAdapter *_adapter;
}

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) GVCollectionViewAdapter *adapter;
@property (nonatomic, strong, readonly) NSArray<GVCollectionViewSection *> *sections;
@property (nonatomic, weak) id<GVCollectionViewPresenterDelegate> delegate;
@end
