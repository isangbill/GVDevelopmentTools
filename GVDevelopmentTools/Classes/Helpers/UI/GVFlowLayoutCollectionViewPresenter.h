//
//  GVFlowLayoutCollectionViewPresenter.h
//  LTPMRuncitCommon
//
//  Created by Sangbill on 2018/8/31.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GVCollectionViewFlowLayout.h"
#import "GVCollectionViewPresenter.h"

@interface GVFlowLayoutCollectionViewPresenter : GVCollectionViewPresenter <GVCollectionViewPresenterDelegate> {
    GVCollectionViewFlowLayout *_layout;
}

@property (nonatomic, strong, readonly) GVCollectionViewFlowLayout *layout;
@property (nonatomic, weak) id<GVCollectionViewDelegateFlowLayout> layoutDelegate;

@end
