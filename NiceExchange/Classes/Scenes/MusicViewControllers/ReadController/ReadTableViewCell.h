//
//  ReadTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ReadTableViewCell_Identifiter @"ReadTableViewCell_Identifiter"

@class ReadTableViewCell;

@protocol ReadTableViewCellDelegate<NSObject>

//关注
- (void)readTableViewPlayBtnClickend:(ReadTableViewCell *)cell;

//用户头像
- (void)readTableViewPlayImageViewClickend:(ReadTableViewCell *)cell;

//用户名
- (void)readtableviewUserNameBtnClickend:(ReadTableViewCell *)cell;

//收藏
- (void)readTableViewCollectBtnClikend:(ReadTableViewCell *)cell;

//参与
- (void)readTableViewparticipationBtnClikend:(ReadTableViewCell *)cell;

@end


@interface ReadTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ImageView;

@property (strong, nonatomic) IBOutlet UIButton *UserNameBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic) IBOutlet UIButton *collectBtn;

@property (strong, nonatomic) IBOutlet UILabel *collectLabel;

@property (strong, nonatomic) IBOutlet UIButton *participationBtn;

@property (strong, nonatomic) IBOutlet UILabel *participationLabel;

@property (strong, nonatomic) IBOutlet UIImageView *BackGroundImageView;

@property (strong, nonatomic) IBOutlet UILabel *subheadingLabel;

@property(nonatomic,assign)id<ReadTableViewCellDelegate>delegate;


@end
