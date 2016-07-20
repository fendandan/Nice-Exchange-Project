//
//  ReadTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "ReadTableViewCell.h"

@implementation ReadTableViewCell







- (IBAction)attentionBtnAction:(UIButton *)sender {
    
  
    
    
    
    
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(readTableViewPlayBtnClickend:)]) {
        
        [_delegate readTableViewPlayBtnClickend:self];
        
    }
    
    
}























- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
