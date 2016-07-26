//
//  ElseTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "ElseTableViewCell.h"

@implementation ElseTableViewCell



- (IBAction)userNameBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(elseTableViewCellUserNameBtnClikend:)]) {
        
        [_delegate elseTableViewCellUserNameBtnClikend:self];
    }
    
    
}

- (IBAction)attentionBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(elseTableViewCellAttentionBtnClickend:)]) {
        
        [_delegate elseTableViewCellAttentionBtnClickend:self];
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




- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(elsetableViewCellUserimageViewClikend:)]) {
        
        [_delegate elsetableViewCellUserimageViewClikend:self];
        
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
