//
//  GVFeedTableViewFooterView.m
//  GVTableViewAdapterVersionTwo
//
//  Created by Sangbill on 2018/8/28.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import "GVFeedTableViewFooterView.h"
#import "UIView+GVExtension.h"

@interface GVFeedTableViewFooterView ()

@end

@implementation GVFeedTableViewFooterView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.containerView];
        self.state = GVFeedTableViewFooterStateNormal;
    }
    return self;
}

#pragma mark - GVFeedTableViewAdapterStateViewProtocol
- (void)emptyDataInTableView:(UITableView *)tableView {
    self.gv_height = tableView.gv_height - tableView.tableHeaderView.gv_height;
    self.state = GVFeedTableViewFooterStateEmpty;
}

- (void)loadingMoreDataInTableView:(UITableView *)tableView {
    self.gv_height = 44.f;
    self.state = GVFeedTableViewFooterStateLoadingMore;
}

- (void)loadMoreDataFailureInTableView:(UITableView *)tableView {
    self.gv_height = 44.f;
    self.state = GVFeedTableViewFooterStateFailed;
}

- (void)endOfPageInTableView:(UITableView *)tableView {
    self.gv_height = 44.f;
    self.state = GVFeedTableViewFooterStateEndOfPage;
}

- (void)normalStateInTableView:(UITableView *)tableView {
    self.gv_height = tableView.gv_height - tableView.tableHeaderView.gv_height;
    self.state = GVFeedTableViewFooterStateNormal;
}

#pragma mark - private methods
- (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize textSize = CGSizeZero;
#if (__IPHONE_OS_VERSION_MIN_REQUIRED && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0)
    
    if (![text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // below ios7
        textSize = [text sizeWithFont:font
                    constrainedToSize:size
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
    else
        
#endif
        
    {
        //iOS 7
        //        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        //        paragraphStyle.lineSpacing = 0.0;//增加行高
        //        paragraphStyle.headIndent = 0;//头部缩进，相当于左padding
        //        paragraphStyle.tailIndent = 0;//相当于右padding
        //        paragraphStyle.lineHeightMultiple = 0;//行间距是多少倍
        //        paragraphStyle.alignment = NSTextAlignmentLeft;//对齐方式
        //        paragraphStyle.firstLineHeadIndent = 0;//首行头缩进
        //        paragraphStyle.paragraphSpacing = 2;//段落后面的间距
        //        paragraphStyle.paragraphSpacingBefore = 2;
        
        CGRect frame = [text boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        textSize = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return textSize;
}

- (void)_normalLayout {
    [self _loadingLayout];
}

- (void)_emptyLayout {
    CGFloat margin = 20.f;
    
    CGFloat labelW = self.frame.size.width - margin * 2;
    CGFloat textW = [self sizeForText:_infoLabel.text withFont:_infoLabel.font constrainedToSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}].width + 20.f;
    labelW = MIN(textW, labelW);
    CGFloat labelH = [self sizeForText:_infoLabel.text withFont:_infoLabel.font constrainedToSize:(CGSize){labelW, CGFLOAT_MAX}].height + 20.f;
    
    
    CGFloat iconW = MIN(self.frame.size.height - margin * 3 - labelH, 120.f);
    
    CGFloat iconY = (self.frame.size.height - iconW - labelH - margin) * 0.5;
    
    _iconImageView.frame = CGRectMake((self.frame.size.width - iconW) * 0.5, iconY, iconW, iconW);
    
    _infoLabel.frame = CGRectMake((self.frame.size.width - labelW) * 0.5, CGRectGetMaxY(_iconImageView.frame) + margin, (int)ceil(labelW), (int)ceil(labelH));
    
    [_activityIndicator stopAnimating];

}

- (void)_loadingLayout {
    CGFloat labelW = [self sizeForText:_infoLabel.text withFont:_infoLabel.font constrainedToSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}].width + 4.f;
    labelW = ceil(labelW);
    
    CGFloat activityW = _activityIndicator.frame.size.width;
    CGFloat margin = 10.f;
    CGFloat containerW = _activityIndicator.frame.size.width + margin + labelW;
    
    CGFloat activityX = (_containerView.frame.size.width - containerW) * 0.5;
    _activityIndicator.frame = CGRectMake(activityX, (_containerView.frame.size.height - activityW) * 0.5, activityW, activityW);
    _infoLabel.frame = CGRectMake(CGRectGetMaxX(_activityIndicator.frame) + margin, 0, labelW, _containerView.frame.size.height);
    
}

- (void)_endOfPageLayout {
    _infoLabel.frame = _containerView.bounds;
}

- (void)_loadMoreDataFailureLayout {
    _infoLabel.frame = _containerView.bounds;
}

#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    self.containerView.frame = self.bounds;
    
    switch (self.state) {
        case GVFeedTableViewFooterStateNormal:
            [self _loadingLayout];
            break;
        case GVFeedTableViewFooterStateLoadingMore:
            [self _loadingLayout];
            break;
        case GVFeedTableViewFooterStateEmpty:
            [self _emptyLayout];
            break;
        case GVFeedTableViewFooterStateEndOfPage:
            [self _endOfPageLayout];
            break;
        case GVFeedTableViewFooterStateFailed:
            [self _loadMoreDataFailureLayout];
            break;
    }
}

#pragma mark - getter & setter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        [_containerView addSubview:self.infoLabel];
        [_containerView addSubview:self.activityIndicator];
        [_containerView addSubview:self.iconImageView];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.hidesWhenStopped = YES;
        [_activityIndicator startAnimating];
    }
    return _activityIndicator;
}

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.00];
        _infoLabel.numberOfLines = 0;
        _infoLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _infoLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.image = [UIImage imageNamed:@"icon_empty"];
    }
    return _iconImageView;
}

- (void)setState:(GVFeedTableViewFooterState)state {
    _state = state;
    switch (state) {
        case GVFeedTableViewFooterStateNormal:
            _infoLabel.text = @"Loading...";
            [_activityIndicator startAnimating];
            _iconImageView.hidden = YES;
            [self _normalLayout];
            break;
        case GVFeedTableViewFooterStateLoadingMore:
            _infoLabel.text = @"Loading...";
            [_activityIndicator startAnimating];
            _iconImageView.hidden = YES;
            [self _loadingLayout];
            break;
        case GVFeedTableViewFooterStateEmpty:
            _iconImageView.hidden = NO;
            _iconImageView.backgroundColor = [UIColor redColor];
            _infoLabel.text = @"No Data Found!";
            [self _emptyLayout];
            break;
        case GVFeedTableViewFooterStateEndOfPage:
            _iconImageView.hidden = YES;
            _infoLabel.text = @"End Of Page";
            [_activityIndicator stopAnimating];
            [self _endOfPageLayout];
            break;
        case GVFeedTableViewFooterStateFailed:
            _iconImageView.hidden = YES;
            _infoLabel.text = @"Loading failed, click to try again!";
            [_activityIndicator stopAnimating];
            [self _loadMoreDataFailureLayout];
            break;
    }
}
@end
