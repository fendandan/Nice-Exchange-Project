//
//  SWUserInfoCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWUserInfoCell;
@class SWLcAvUSer;

@protocol UserIfonCellDelegate <NSObject>

- (void)userIfonTableViewLoginButtonClicked:(SWUserInfoCell *)cell;

@end

@interface SWUserInfoCell : UITableViewCell

@property (strong, nonatomic) UIImageView *portraitView;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) SWUserInfoView *userInfoView;

@property (weak, nonatomic) id<UserIfonCellDelegate> delegate;

@property (strong, nonatomic) SWLcAvUSer *avUser;

@end
