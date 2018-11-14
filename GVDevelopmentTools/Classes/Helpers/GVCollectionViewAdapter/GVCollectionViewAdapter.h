//
//  GVCollectionViewAdapter.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/5.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GVCollectionViewSection.h"

@protocol GVCollectionViewAdapterDelegate <UICollectionViewDelegate>
@required
- (NSMutableArray<__kindof GVCollectionViewSection *> *)sectionsForCollectionView:(UICollectionView *)collectionView;
- (NSSet<NSString *> *)collectionViewCellIdentifiterSetForCollectionView:(UICollectionView *)collectionView;
@optional
- (void)collectionView:(UICollectionView *)collectionView configuredCell:(UICollectionViewCell *)cell withItem:(GVCollectionViewItem *)item atIndexPath:(NSIndexPath *)indexPath;
@end

@interface GVCollectionViewAdapter : NSObject {
    NSSet<NSString *> *_cellIdentifierSet;
    NSMutableArray<__kindof GVCollectionViewSection *> *_sections;
}

@property (nonatomic, strong, readonly) NSMutableArray<__kindof GVCollectionViewSection *> *sections;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) id<GVCollectionViewAdapterDelegate> delegate;
@property (nonatomic, strong, readonly) NSSet<NSString *> *cellIdentifierSet;

- (instancetype)initWithViewCollectionView:(UICollectionView *)collectionView;
- (void)reloadData;
@end
