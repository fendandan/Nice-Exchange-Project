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

- (void)setComment:(SWComment *)comment {
    
    if (_comment != comment) {
        _comment = nil;
        _comment = comment;
        
        
        if (comment.commentBy.displayName) {
            self. userName.text = comment.commentBy.displayName;
        }else {
            
            self. userName.text = comment.commentBy.username;
        }
        
    
        AVFile *ff = [AVFile fileWithURL:comment.commentBy.userImage.url];
        [ff getThumbnail:YES width:200 height:200 withBlock:^(UIImage *image, NSError *error) {
            [self.jionImg  setImage:image forState:(UIControlStateNormal)];
        }];
            
        /**
         *  标题
         */
        self.activityL.text = comment.forActivity.title;
        /**
         *  参与数
         */
        AVRelation *relation = [comment.forActivity relationForKey:@"commentRelation"];
        AVQuery *query = [relation query];
        [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
#warning --------------------------------------------------
            self.ioinCountL.text = [NSString stringWithFormat:@"%ld",number];
        }];
//
        /**
         *  内容
         */
        self.detailL.text = comment.forActivity.subhead;
        [self.detailImage setImageWithURL:[NSURL URLWithString:comment.commentBy.userImage.url]];
        /**
         * 评论内容
         */
         self.UdetailL.text =comment.commentContent;
        /**
         *  赞
         */
        self.goodPL.text = comment.goodCount.stringValue;
        /**
         *  呵呵
         */
       self.badPL.text = comment.lowCount.stringValue;
        

    }
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
