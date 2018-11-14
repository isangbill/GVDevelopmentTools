//
//  GVWaterFlowLayout.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/8/31.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVWaterFlowLayout;

@protocol GVWaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat)waterFlowLayout:(GVWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath withItemWidth:(CGFloat)itemWidth;

@optional
- (NSInteger)numOfColumnInWaterFlowLayout:(GVWaterFlowLayout *)layout;
- (NSInteger)numOfColumnInWaterFlowLayout:(GVWaterFlowLayout *)layout;
@end

@interface GVWaterFlowLayout : UICollectionViewLayout

@end
