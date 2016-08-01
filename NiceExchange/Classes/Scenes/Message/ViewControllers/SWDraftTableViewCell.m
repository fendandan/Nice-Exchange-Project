//
//  SWDraftTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/29.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWDraftTableViewCell.h"

@implementation SWDraftTableViewCell

-(void)setModel:(SWDraftModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    _titleLabel.text = _model.title;
    _timeLabel.text = _model.time;
}

- (IBAction)deleteBtn:(UIButton *)sender {
    

    if (_delegate && [_delegate respondsToSelector:@selector(SWDraftTableViewPlayBtnClickend:)]) {
        [_delegate SWDraftTableViewPlayBtnClickend:self];
    }
}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
