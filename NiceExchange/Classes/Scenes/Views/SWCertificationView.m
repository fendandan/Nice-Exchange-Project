//
//  SWCertificationView.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWCertificationView.h"

@implementation SWCertificationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kSelfWidth / 6, 130, kSelfWidth * 2 / 3, 38)];
    self.userNameTextField.placeholder = @"用户名/邮箱";
    self.userNameTextField.layer.cornerRadius = 5;
    self.userNameTextField.layer.borderWidth = 0.5;
    self.userNameTextField.layer.borderColor = [UIColor colorWithRed:246/256.0 green:246/256.0 blue:246/256.0 alpha:1.0].CGColor;
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(kSelfWidth / 6, CGRectGetMaxY(self.userNameTextField.frame) + 10, kSelfWidth * 2 / 3, 38)];
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.layer.borderWidth = 0.5;
    self.passwordTextField.layer.borderColor = kBorderColor;
    
    [self addSubview:self.userNameTextField];
    [self addSubview:self.passwordTextField];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
