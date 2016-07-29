//
//  ElseTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ElseTableViewCell_Identifiter @"ElseTableViewCell_Identifiter"

@class ElseTableViewCell;

@protocol ElseTableViewCellDelegate <NSObject>

- (void)elseTableViewCellAttentionBtnClickend:(ElseTableViewCell *)cell;

- (void)elsetableViewCellUserimageViewClikend:(ElseTableViewCell *)cell;

- (void)elseTableViewCellUserNameBtnClikend:(ElseTableViewCell *)cell;

@end


@interface ElseTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;

@property (strong, nonatomic) IBOutlet UIButton *userNameBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic) IBOutlet UIButton *collectBtn;

@property (strong, nonatomic) IBOutlet UILabel *collectLabel;

@property (strong, nonatomic) IBOutlet UIButton *participationBtn;

@property (strong, nonatomic) IBOutlet UILabel *participationLabel;

@property (strong, nonatomic) IBOutlet UIImageView *BackGroundImageView;


@property (strong, nonatomic) IBOutlet UILabel *subHeadLabel;



@property(nonatomic,assign)id<ElseTableViewCellDelegate>delegate;


@end
