//
//  MoodTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MoodTableViewCell.h"

@implementation MoodTableViewCell



- (IBAction)userNameBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(moodTableViewUserNameBtnClikend:)]) {
        
        [_delegate moodTableViewUserNameBtnClikend:self];
    }
    
    
}


- (IBAction)attentionBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(moodTableViewAttentionPlayBtnClikend:)]) {
        [_delegate moodTableViewAttentionPlayBtnClikend:self];
    }
    
    
}


- (IBAction)collectBtn:(UIButton *)sender {
    
   
}


- (IBAction)participationBtn:(UIButton *)sender {
    
    

}


- (void)awakeFromNib {
    self.titleImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    
    [self.titleImageView addGestureRecognizer:tapGesture];
    
}


//
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(moodTableViewUserNameImageViewPlay:)]) {
        [_delegate moodTableViewUserNameImageViewPlay:self];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
