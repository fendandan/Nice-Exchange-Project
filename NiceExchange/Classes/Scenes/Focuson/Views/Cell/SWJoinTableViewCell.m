//
//  SWJoinTableViewCell.m
//  
//
//  Created by Spacewalk on 16/7/14.
//
//

#import "SWJoinTableViewCell.h"

@implementation SWJoinTableViewCell

- (void)awakeFromNib {
    
    //头像切圆角
    self.jionImg.layer.cornerRadius = self.jionImg.frame.size.width / 2;
   self.jionImg.layer.borderWidth = 1.0;
   self.jionImg.layer.borderColor =[UIColor clearColor].CGColor;
    self.jionImg.clipsToBounds = TRUE;//去除边界

    
    //view 切角
    self.unView.layer.masksToBounds = YES;
    self.unView.layer.cornerRadius = 20;
    self.unView.layer.borderWidth = 10.0;
    self.unView.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.jionImg addTarget:self action:@selector(clickAction) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)clickAction {
    
    if ([self.joinDelegate respondsToSelector:@selector(onJoinClick)]) {
        [self.joinDelegate onJoinClick];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
