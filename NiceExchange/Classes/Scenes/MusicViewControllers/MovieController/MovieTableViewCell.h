//
//  MovieTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MovieTableViewCell_Identifiter @"MovieTableViewCell_Identifiter"

@class MovieTableViewCell;

@protocol movieTableViewCellDelegate <NSObject>

- (void)movieTableViewplayBtnClickend:(MovieTableViewCell *)cell;

- (void)movieTableViewUserImageViewClickend:(MovieTableViewCell *)cell;

- (void)movieTableViewUserNameBtnClickend:(MovieTableViewCell *)cell;


@end


@interface MovieTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ImageView;

@property (strong, nonatomic) IBOutlet UIButton *userNameBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic) IBOutlet UIButton *collectBtn;

@property (strong, nonatomic) IBOutlet UILabel *collectLabel;

@property (strong, nonatomic) IBOutlet UIButton *participationBtn;

@property (strong, nonatomic) IBOutlet UILabel *participationLabel;

@property (strong, nonatomic) IBOutlet UIImageView *BackGroundImageView;

@property(nonatomic,assign)id<movieTableViewCellDelegate>delegate;

@end
