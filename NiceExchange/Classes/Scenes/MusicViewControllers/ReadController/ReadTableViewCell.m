//
//  ReadTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "ReadTableViewCell.h"
#import "SWshowViewController.h"

@implementation ReadTableViewCell

- (IBAction)attentionBtnAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(readTableViewPlayBtnClickend:)]) {
        
        [_delegate readTableViewPlayBtnClickend:self];
        
    }
}


- (IBAction)userNameBtn:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(readtableviewUserNameBtnClickend:)]) {
        
        [_delegate readtableviewUserNameBtnClickend:self];
    }
    
    
}


//收藏按钮
- (IBAction)collectBtn:(UIButton *)sender {
//    SWActivityList *activity = [SWActivityList object];
//    if (sender.selected == YES) {
//        
//        [LCManager lcToCancelMarkActivityWithActivityList:activity completion:^(NSArray *mArray) {
//            
//            LCManager.shareManagerBm = NO;
//            
//        }];
//        
//    }else if (sender.selected == NO) {
//        
//        [LCManager lcToMarkActivityWithActivityList:activity completion:^(NSArray *mArray) {
//           
//            LCManager.shareManagerBm = NO;
//            
//        }];
//    }
    
   
}


//参与按钮
- (IBAction)participationBtn:(UIButton *)sender {
    
    
    
    
}



- (void)awakeFromNib {

    self.ImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.ImageView addGestureRecognizer:tapGesture];
    

}



//imageView 的点击事件
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(readTableViewPlayImageViewClickend:)]) {
        
        [_delegate readTableViewPlayImageViewClickend:self];
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
