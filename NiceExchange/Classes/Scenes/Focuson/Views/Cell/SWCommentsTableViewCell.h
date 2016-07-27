//
//  SWCommentsTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/21.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentDelegate <NSObject>

-(void)onAction;

@end


@interface SWCommentsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *FocusB;

@property (strong, nonatomic) IBOutlet UIButton *iconimv;
@property (strong, nonatomic) IBOutlet UILabel *commentLLL;
@property (strong, nonatomic) IBOutlet UIButton *praiseB;
@property (strong, nonatomic) IBOutlet UIButton *HaHaL;
@property (strong, nonatomic) IBOutlet UIButton *commentsL;
@property (strong, nonatomic) IBOutlet UILabel *userNL;


@property (nonatomic,assign) NSInteger touch;

@property (nonatomic,weak) id<CommentDelegate>commentDelegate;





@property(nonatomic,strong) SWComment *comment;




@end
