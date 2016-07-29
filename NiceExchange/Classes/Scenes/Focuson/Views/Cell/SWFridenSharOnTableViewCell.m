//
//  SWFridenSharOnTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWFridenSharOnTableViewCell.h"

@implementation SWFridenSharOnTableViewCell

- (void)awakeFromNib {
    //头像切圆角
    self.Friendicon.layer.cornerRadius = self.Friendicon.frame.size.width / 2;
    self.Friendicon.layer.borderWidth = 1.0;
    self.Friendicon.layer.borderColor =[UIColor clearColor].CGColor;
    self.Friendicon.clipsToBounds = TRUE;//去除边界
//    //image
//    self.detailImv.layer.masksToBounds = YES;
//    self.detailImv.layer.cornerRadius = 20;
//    self.detailImv.layer.borderWidth = 10.0;
//    self.detailImv.layer.borderColor = [[UIColor whiteColor] CGColor];

    
    //view 切角
    self.unView.layer.masksToBounds = YES;
    self.unView.layer.cornerRadius = 20;
    self.unView.layer.borderWidth = 10.0;
    self.unView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self.Friendicon addTarget:self action:@selector(clickAction) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)clickAction {
    
    if ([self.friendDelegate respondsToSelector:@selector(onClick:)]) {
        [self.friendDelegate onClick:self];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
