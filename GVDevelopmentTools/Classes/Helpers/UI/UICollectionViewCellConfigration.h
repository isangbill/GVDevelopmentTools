//
//  UICollectionViewCellConfigration.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/11.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#ifndef UICollectionViewCellConfigration_h
#define UICollectionViewCellConfigration_h

@class GVCollectionViewItem;

@protocol UICollectionViewCellConfigration <NSObject>
- (void)setupItem:(__kindof GVCollectionViewItem *)item;
@end

#endif /* UICollectionViewCellConfigration_h */
