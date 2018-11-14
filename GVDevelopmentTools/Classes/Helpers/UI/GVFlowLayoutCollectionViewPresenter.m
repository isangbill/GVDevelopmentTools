//
//  GVFlowLayoutCollectionViewPresenter.m
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/8/31.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVFlowLayoutCollectionViewPresenter.h"
@interface GVFlowLayoutCollectionViewPresenter () <GVCollectionViewDelegateFlowLayout>

@end

@implementation GVFlowLayoutCollectionViewPresenter

#pragma mark - GVCollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(GVCollectionViewFlowLayout *)collectionViewLayout numberOfColumnsInSection:(NSInteger)section {
    if ([self.layoutDelegate respondsToSelector:@selector(collectionView:layout:numberOfColumnsInSection:)]) {
        return [self.layoutDelegate collectionView:collectionView layout:collectionViewLayout numberOfColumnsInSection:section];
    } else {
        return 4;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.layoutDelegate && [self.layoutDelegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.layoutDelegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    } else {
        return 2;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.layoutDelegate && [self.layoutDelegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.layoutDelegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return 2;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.layoutDelegate && [self.layoutDelegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.layoutDelegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    } else {
        return UIEdgeInsetsMake(2, 2, 2, 2);
    }
}

#pragma mark - GVCollectionViewPresenterDelegate
- (UICollectionViewFlowLayout *)collectionViewLayoutForCollectionViewPresenter:(GVCollectionViewPresenter *)collectionViewPresenter {
    return self.layout;
}

#pragma mark - getter & setter
- (GVCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [GVCollectionViewFlowLayout new];
        _layout.delegate = self;
    }
    return _layout;
}
@end
