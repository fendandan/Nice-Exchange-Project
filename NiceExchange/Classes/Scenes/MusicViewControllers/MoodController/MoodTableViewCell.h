//
//  MoodTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MoodTableViewCell_Identifiter @"MoodTableViewCell_Identifiter"

@class MoodTableViewCell;

@protocol MoodTableViewCellDelegate <NSObject>

- (void)moodTableViewAttentionPlayBtnClikend:(MoodTableViewCell *)cell;

- (void)moodTableViewUserNameImageViewPlay:(MoodTableViewCell *)cell;

- (void)moodTableViewUserNameBtnClikend:(MoodTableViewCell *)cell;


@end


@interface MoodTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic) IBOutlet UIButton *collectBtn;

@property (strong, nonatomic) IBOutlet UILabel *collectLabel;

@property (strong, nonatomic) IBOutlet UIButton *participationBtn;

@property (strong, nonatomic) IBOutlet UILabel *participationLabel;

@property (strong, nonatomic) IBOutlet UIImageView *BackGroundImageView;


@property(nonatomic,assign)id<MoodTableViewCellDelegate>delegate;


@end
