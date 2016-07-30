//
//  SWCommentsTableViewCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/21.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWCommentsTableViewCell.h"
@class SWCommentsTableViewCell;
@implementation SWCommentsTableViewCell

- (void)awakeFromNib {
   
    //头像切圆角
    self.iconimv.layer.cornerRadius = self.iconimv.frame.size.width / 2;
    self.iconimv.layer.borderWidth = 1.0;
    self.iconimv.layer.borderColor =[UIColor clearColor].CGColor;
    self.iconimv.clipsToBounds = TRUE;//去除边界
    self.touch = 0;
  
#warning ---- %d",0]  这里面传入值 例如  %d",0 + self.title.text];
    
    
    [self.praiseB setTitle:[NSString stringWithFormat:@"赞  %d",2]forState:0];
    [self.praiseB setImage:[UIImage imageNamed:@"心"] forState:0];

    [self.HaHaL setTitle:[NSString stringWithFormat:@"呵呵  %d",2] forState:0];
    [self.HaHaL setImage:[UIImage imageNamed:@"呵呵"] forState:0];



    [self.commentsL setTitle:[NSString stringWithFormat:@"评论  %d",2] forState:0];
[self.commentsL setImage:[UIImage imageNamed:@"评论轮.png"] forState:0];



 [self.FocusB setTitle:@"+ 关注 " forState:0];


}

- (IBAction)praiseBClick:(UIButton *)sender {
 
    if (self.touch == 0) {
        [self.praiseB setTitleColor:[UIColor cyanColor] forState:0];
        self.praiseB.tintColor = [UIColor cyanColor];

    [self.praiseB setTitle:[NSString stringWithFormat:@"赞  %d",1]forState:0];
        
        self.touch = 1;
    }else if( self.touch == 1) {
        
    [self.praiseB setTitle:[NSString stringWithFormat:@"赞  %d",0]forState:0];
        [self.praiseB setImage:[UIImage imageNamed:@"心"] forState:0];
    
        [self.praiseB setTitleColor:[UIColor groupTableViewBackgroundColor] forState:0];
        self.praiseB.tintColor = [UIColor groupTableViewBackgroundColor];
        
        self.touch = 0;
    }
    
    
}
- (IBAction)HaHaLClick:(UIButton *)sender {
    
    
    if (self.touch == 0) {
        [self.HaHaL setTitleColor:[UIColor cyanColor] forState:0];
        self.HaHaL.tintColor = [UIColor cyanColor];
        
        [self.HaHaL setTitle:[NSString stringWithFormat:@"呵呵  %d",1]forState:0];
        
        self.touch = 1;
    }else if( self.touch == 1) {
        
        [self.HaHaL setTitle:[NSString stringWithFormat:@"呵呵  %d",0]forState:0];
        [self.HaHaL setImage:[UIImage imageNamed:@"呵呵"] forState:0];
        
        [self.HaHaL setTitleColor:[UIColor groupTableViewBackgroundColor] forState:0];
        self.HaHaL.tintColor = [UIColor groupTableViewBackgroundColor];
        
        self.touch = 0;
    }
    
    
    
    
}
- (IBAction)commentsLClick:(id)sender {
    
    
    
    [self.commentsL addTarget:self action:@selector(touchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    if (self.touch == 0) {
        [self.commentsL setTitleColor:[UIColor cyanColor] forState:0];
        self.commentsL.tintColor = [UIColor cyanColor];
        
               self.touch = 1;
    }else if( self.touch == 1) {
        
                [self.commentsL setImage:[UIImage imageNamed:@"评论轮.png"] forState:0];
           
        [self.commentsL setTitleColor:[UIColor groupTableViewBackgroundColor] forState:0];
        self.commentsL.tintColor = [UIColor groupTableViewBackgroundColor];
        
        self.touch = 0;
    }
    
    
    
}

-(void) touchAction:(UIButton *)sender {
    
    
    if ([self.commentDelegate respondsToSelector:@selector(onAction:)]) {
        
        [self.commentDelegate onAction:self];
    }
    
    
}


- (IBAction)focusChage:(UIButton *)sender {
    
    
    if (self.touch == 0) {
        
        [self.FocusB setTitle:@"+ 关注 " forState:0];
        
        
        self.touch = 1;
    }else if( self.touch == 1) {
        
         [self.FocusB setTitle:@"已关注" forState:0];
        
        self.touch = 0;
    }

    
}
#warning -------------
- (void)setComment:(SWComment *)comment {
    
    if (_comment !=comment) {
        _comment = nil;
        _comment = comment;
        
        self.commentLLL.text = comment.commentContent;
        
        [self.commentsL setTitle:comment.commentCount.stringValue forState:(UIControlStateNormal)];
        [self.praiseB  setTitle:comment.goodCount.stringValue forState:(UIControlStateNormal)];
        [self.HaHaL setTitle:comment.lowCount.stringValue forState:(UIControlStateNormal)];
        NSLog(@"----------- %@", comment.commentBy.objectId);
        AVQuery *aQ = [AVQuery queryWithClassName:@"_User"];
        //        [aQ includeKey:@"userImage"];
        [aQ whereKey:@"objectId" equalTo:comment.commentBy.objectId];
        [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            SWLcAvUSer *user = (SWLcAvUSer *)objects[0];
            
            
            AVFile *ff = [AVFile fileWithURL:user.userImage.url];
            
            
            self.userNL.text = user.username;
        
            NSLog(@"++++++++ %@ %@", user.username, self.userNL);
            [ff getThumbnail:YES width:200 height:200 withBlock:^(UIImage *image, NSError *error) {
                [self.iconimv  setImage:image forState:(UIControlStateNormal)];
                
            }];
        }];

        
        
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
