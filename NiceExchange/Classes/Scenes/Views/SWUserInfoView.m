//
//  SWUserInfoView.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWUserInfoView.h"

@implementation SWUserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}

- (void)drawView {
    
    [self addSubview:self.goodLabel];
    [self addSubview:self.markLabel];
    [self addSubview:self.recommendationLabel];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, kSelfHeight / 2 - 1, kSelfWidth - 40, 1)];
    lineView.backgroundColor = kBorderColor;
    [self addSubview:lineView];
    
}

- (UILabel *)goodLabel {
    if (!_goodLabel) {
        _goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSelfWidth / 5, kSelfHeight / 2 - 18, kSelfWidth / 5, 15)];
//        _goodLabel.backgroundColor = [UIColor colorWithRed:kColor green:kColor blue:kColor alpha:1.0];
        _goodLabel.font = [UIFont systemFontOfSize:15.0];
        _goodLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _goodLabel;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSelfWidth * 2 / 5, kSelfHeight / 2 - 18, kSelfWidth / 5, 15)];
//        _markLabel.backgroundColor = [UIColor colorWithRed:kColor green:kColor blue:kColor alpha:1.0];
        _markLabel.font = [UIFont systemFontOfSize:15.0];
        _markLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _markLabel;
}

- (UILabel *)recommendationLabel {
    if (!_recommendationLabel) {
        _recommendationLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSelfWidth * 3 / 5, kSelfHeight / 2 - 18, kSelfWidth / 5, 15)];
//        _recommendationLabel.backgroundColor = [UIColor colorWithRed:kColor green:kColor blue:kColor alpha:1.0];
        _recommendationLabel.font = [UIFont systemFontOfSize:15.0];
        _recommendationLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _recommendationLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
