//
//  GVCollectionTableViewCell.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/9.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import "GVCollectionTableViewCell.h"

@interface GVCollectionTableViewCell () <GVCollectionViewAdapterDelegate>
@property (nonatomic, strong) GVCollectionViewPresenter *collectionViewPresenter;
@end

@implementation GVCollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.collectionViewPresenter.collectionView];
    }
    return self;
}

#pragma mark - GVCollectionViewAdapterDelegate
- (NSSet<NSString *> *)collectionViewCellIdentifiterSetForCollectionView:(UICollectionView *)collectionView {
    return [self.row collectionViewCellIdentifiterSetForCollectionView:collectionView];
}

- (NSMutableArray<GVCollectionViewSection *> *)sectionsForCollectionView:(UICollectionView *)collectionView {
    return [self.row sectionsForCollectionView:collectionView];
}

#pragma mark - getter & setter
- (GVCollectionViewPresenter *)collectionViewPresenter {
    if (!_collectionViewPresenter) {
        _collectionViewPresenter = [GVCollectionViewPresenter new];
    }
    return _collectionViewPresenter;
}

- (void)setRow:(id<GVCollectionTableViewCellDelegate>)row {
    _row = row;
    self.collectionViewPresenter.delegate = row;
    self.collectionViewPresenter.adapter.delegate = self;
    self.collectionViewPresenter.collectionView.frame = row.layout.collectionViewFrame;
    [self.collectionViewPresenter.adapter reloadData];
}

- (void)setupRowModel:(__kindof GVTableViewRow *)row {
    self.row = row;
}

@end
