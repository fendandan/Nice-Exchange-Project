//
//  MovieTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell





- (IBAction)userNameBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(movieTableViewUserNameBtnClickend:)]) {
        [_delegate movieTableViewUserNameBtnClickend:self];
    }
}


- (IBAction)attentionBtn:(UIButton *)sender {
    
    if (_delegate &&[_delegate respondsToSelector:@selector(movieTableViewplayBtnClickend:)]) {
        
        [_delegate movieTableViewplayBtnClickend:self];
    }
}


- (IBAction)collectBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(movieTableViewCollectBtnClickend:)]) {
        
        [_delegate movieTableViewCollectBtnClickend:self];
        
    }
    
    
}


- (IBAction)participationBtn:(UIButton *)sender {
}



- (void)awakeFromNib {
    
    self.ImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [self.ImageView addGestureRecognizer:tap];
}



- (void)tapAction:(UITapGestureRecognizer *)sender
{
    
    if (_delegate &&[_delegate respondsToSelector:@selector(movieTableViewUserImageViewClickend:)]) {
        
        [_delegate movieTableViewUserImageViewClickend:self];
        
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
