//
//  GVCollectionViewPresenter.m
//  GVWalletMain
//
//  Created by Sangbill on 2018/10/9.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#import "GVCollectionViewPresenter.h"
#import "GVCollectionViewAdapter.h"

@interface GVCollectionViewPresenter () <UICollectionViewDelegate>
@property (nonatomic, strong) GVCollectionViewAdapter *adapter;
@end

@implementation GVCollectionViewPresenter
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(GVCollectionViewPresenterDelegate)]) {
            self.delegate = (GVCollectionViewPresenter<GVCollectionViewPresenterDelegate> *) self;
        }
    }
    return self;
}

#pragma mark - getter & setter
- (void)setDelegate:(id<GVCollectionViewPresenterDelegate>)delegate {
    _delegate = delegate;
    if ([delegate respondsToSelector:@selector(collectionViewLayoutForCollectionViewPresenter:)]) {
        if (_collectionView) { 
            _collectionView.collectionViewLayout = [delegate collectionViewLayoutForCollectionViewPresenter:self];
        }
    }
}

- (GVCollectionViewAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[GVCollectionViewAdapter alloc] initWithViewCollectionView:self.collectionView];
    }
    return _adapter;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        if ([self.delegate respondsToSelector:@selector(collectionViewLayoutForCollectionViewPresenter:)]) {
            _collectionView.collectionViewLayout = [self.delegate collectionViewLayoutForCollectionViewPresenter:self];
        }
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
@end
