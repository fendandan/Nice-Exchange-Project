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

- (void)readTableViewPlayBtnClickend:(ReadTableViewCell *)cell;

- (void)readTableViewPlayImageViewClickend:(ReadTableViewCell *)cell;

- (void)readtableviewUserNameBtnClickend:(ReadTableViewCell *)cell;

- (void)readTableViewCollectBtnClikend:(ReadTableViewCell *)cell;

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
