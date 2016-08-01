//
//  SWDraftTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/29.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWDraftTableViewCell;
#import "SWDraftModel.h"

#define SWDraftTableViewCell_Identifiter @"SWDraftTableViewCell_Identifiter"


@protocol SWDraftTableViewCellDelegate<NSObject>


- (void)SWDraftTableViewPlayBtnClickend:(SWDraftTableViewCell *)cell;


@end



@interface SWDraftTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@property (strong, nonatomic) IBOutlet UILabel *timeLabel;



@property(nonatomic,assign)id<SWDraftTableViewCellDelegate>delegate;


@property(nonatomic,strong)SWDraftModel *model;


@end
