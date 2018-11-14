//
//  GVCollectionViewFlowLayout.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/8/31.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVCollectionViewFlowLayout;

@protocol GVCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@required
/**
 *  The delegate method set the collectionView will flow layout as the number columns in each section.
 *
 *  @param collectionView The effect collectionView
 *  @param collectionViewLayout         The GVCollectionViewFlowLayout inilization object.
 *  @param section        The section index
 *
 *  @return The number of columns in each section.
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
                     layout:(GVCollectionViewFlowLayout *)collectionViewLayout
   numberOfColumnsInSection:(NSInteger)section;


/**
 返回指定索引的 item 的高度，约束于指定的宽度
 ps: 如果实现该方法，会覆盖其他设置 item 高度的方法
 
 @param collectionView 指定的 collectionView
 @param collectionViewLayout collectionView 的 layout 对象
 @param indexPath 指定的索引
 @param itemWidth 受限的宽度
 @return 约束于指定的宽度计算得出的高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView
                     layout:(GVCollectionViewFlowLayout *)collectionViewLayout
   heightForItemAtIndexPath:(NSIndexPath *)indexPath constraintedOnItemWidth:(CGFloat)itemWidth;

@optional
- (void)collectionView:(UICollectionView *)collectionView didFinishedLayoutWithCollectionLayout:(GVCollectionViewFlowLayout *)collectionViewLayout;

@end


@interface GVCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<GVCollectionViewDelegateFlowLayout> delegate;
/**
 *  Defalut is NO, set it's YES the collectionView's header will sticky on the section top.
 */
@property (nonatomic) BOOL sectionHeadersStickyEnable;

@end
