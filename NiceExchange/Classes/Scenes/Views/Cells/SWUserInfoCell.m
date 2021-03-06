//
//  SWUserInfoCell.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWUserInfoCell.h"

@implementation SWUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)setAvUser:(SWLcAvUSer *)avUser {
    if (_avUser != avUser) {
        _avUser = nil;
        _avUser = avUser;
        
        
        
        if (avUser.userImage.url) {
            [self.portraitView setImageWithURL:[NSURL URLWithString:avUser.userImage.url]];
        }else {
            [self.portraitView setImageWithURL:[NSURL URLWithString:@"http://ac-8nI1eCRt.clouddn.com/XJT3FKPr096iVDIpDUfVJtA.jpg"]];
        }
        
        if (avUser.displayName) {
            self.userNameLabel.text = avUser.displayName;
        }else {
            self.userNameLabel.text = avUser.username;
        }
        // 查询计数数量
        AVQuery *countQ = [AVQuery queryWithClassName:@"Count"];
        [countQ whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
        [countQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count != 0) {
                SWCount *count = objects[0];
                self.userInfoView.markLabel.text = [NSString stringWithFormat:@"关注:%@",count.followC];
                self.userInfoView.recommendationLabel.text = [NSString stringWithFormat:@"粉丝:%@",count.followedC];
//                cell.numberlabel.text = [count.followC stringValue];
                SWLog(@"%@",count);
            }
            
        }];
        
        
    }
}

- (void)createView {
    [self addSubview:self.portraitView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.loginButton];
    [self addSubview:self.userInfoView];
}

- (UIImageView *)portraitView {
    if (!_portraitView) {
        _portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, kSelfWidth / 3, kSelfWidth / 3)];
        _portraitView.layer.cornerRadius = kSelfWidth / 6;
        _portraitView.layer.masksToBounds = YES;
//        _portraitView.backgroundColor = [UIColor colorWithRed:kColor green:kColor blue:kColor alpha:1.0];
    }
    return _portraitView;
}
- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.portraitView.frame) + 30, self.portraitView.center.y - 25, kSelfWidth / 6, 15)];
        _userNameLabel.font = [UIFont systemFontOfSize:12];
//        _userNameLabel.backgroundColor = [UIColor colorWithRed:kColor green:kColor blue:kColor alpha:1.0];
    }
    return _userNameLabel;
}
- (UIButton *)loginButton {
    if (!_loginButton) {
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(CGRectGetMaxX(self.portraitView.frame) + 30, self.portraitView.center.y + 10, kSelfWidth / 3, 15);
        
        //    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        //    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Selected",imageName]] forState:UIControlStateSelected];
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius = 2;
        _loginButton.layer.borderWidth = 0.5;
        _loginButton.layer.borderColor = kBorderCGColor;
        
        [_loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_loginButton setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor magentaColor] forState:UIControlStateHighlighted];
    }
    
    return _loginButton;
}
- (void)loginButtonClicked:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(userIfonTableViewLoginButtonClicked:)]) {
        [_delegate userIfonTableViewLoginButtonClicked:self];
    }
}

- (SWUserInfoView *)userInfoView {
    if (!_userInfoView) {
        _userInfoView = [[SWUserInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.portraitView.frame) + 15 , kScreenWidth, 60)];
    }
    return _userInfoView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
