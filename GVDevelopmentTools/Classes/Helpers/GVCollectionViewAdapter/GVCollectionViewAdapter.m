//
//  GVCollectionViewAdapter.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/5.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVCollectionViewAdapter.h"
#import "UICollectionViewCellConfigration.h"

@interface GVCollectionViewAdapter () <UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation GVCollectionViewAdapter
- (instancetype)initWithViewCollectionView:(UICollectionView *)collectionView {
    if (!collectionView) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _sections = [NSMutableArray array];
        self.collectionView = collectionView;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    return self;
}

#pragma mark - public methods
- (void)reloadData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionsForCollectionView:)]) {
        _sections = [self.delegate sectionsForCollectionView:self.collectionView];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GVCollectionViewSection *section = self.sections[indexPath.section];
    section.index = indexPath.section;
    
    GVCollectionViewItem *item = section.items[indexPath.item];
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:item.cellIdentifier forIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(collectionView:configuredCell:withItem:atIndexPath:)]) {
        [self.delegate collectionView:collectionView configuredCell:cell withItem:item atIndexPath:indexPath];
    }
    
    if ([cell conformsToProtocol:@protocol(UICollectionViewCellConfigration)]) {
        [(UICollectionViewCell<UICollectionViewCellConfigration> *)cell setupItem:item];
    }
    
    return cell;
}

#pragma mark - GVCollectionViewAdapterDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - getter & setter
- (void)setDelegate:(id<GVCollectionViewAdapterDelegate>)delegate {
    _delegate = delegate;
    if ([delegate respondsToSelector:@selector(collectionViewCellIdentifiterSetForCollectionView:)]) {
        NSSet<NSString *> *cellIdentifierSet = [delegate collectionViewCellIdentifiterSetForCollectionView:self.collectionView];
        _cellIdentifierSet = cellIdentifierSet;
        
        for (NSString *ID in cellIdentifierSet) {
            [_collectionView registerClass:NSClassFromString(ID) forCellWithReuseIdentifier:ID];
        }
    }
    
    if ([delegate respondsToSelector:@selector(sectionsForCollectionView:)]) {
        _sections = [delegate sectionsForCollectionView:self.collectionView];
    }
}

- (NSSet<NSString *> *)cellIdentifierSet {
    if (!_cellIdentifierSet) {
        _cellIdentifierSet = [NSSet set];
    }
    return _cellIdentifierSet;
}

- (NSMutableArray<GVCollectionViewSection *> *)sections {
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

@end
