//
//  SWRegisterViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWRegisterViewController.h"

@interface SWRegisterViewController ()

@property (strong, nonatomic) SWCertificationView *lrView;

@end

@implementation SWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRegisterView];
}

- (void)createRegisterView{
    self.lrView = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2 / 3)];
    [self.view addSubview:self.lrView];
    [self addButton];
}
- (void)addButton {
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lButton.frame = CGRectMake(kScreenWidth / 6, kScreenHeight * 2 / 3 - 74, kScreenWidth * 2 / 3, 38);
    lButton.backgroundColor = [UIColor grayColor];
    //    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Selected",imageName]] forState:UIControlStateSelected];
    [lButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    lButton.layer.cornerRadius = 5;
    lButton.layer.borderWidth = 0.5;
    lButton.layer.borderColor = kBorderColor;
    
    [lButton setTitle:@"注册" forState:UIControlStateNormal];
    lButton.titleLabel.font = [UIFont systemFontOfSize:26];
    lButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [lButton setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [lButton setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    
    UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rButton.frame = CGRectMake(kScreenWidth * 5 / 6 - 72, kScreenHeight * 2 / 3 - 35, 72, 12);
    [rButton addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [rButton setTitle:@">>别的注册" forState:UIControlStateNormal];
    rButton.titleLabel.font = [UIFont systemFontOfSize:12];
    rButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rButton setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateHighlighted];
    
    
    [self.view addSubview:lButton];
    [self.view addSubview:rButton];
    
    
}

- (void)registerButtonClicked:(UIButton *)button {
    SWLogFunc;
    AVUser *user = [AVUser user];// 新建 AVUser 对象实例
    user.username = self.lrView.userNameTextField.text;// 设置用户名
    user.password = self.lrView.passwordTextField.text;// 设置密码
    user.email = @"tom@leancloud.cn";// 设置邮箱
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功
            SWLog(@"succeeded = %d",succeeded);
        } else {
            // 失败的原因可能有多种，常见的是用户名已经存在。
            SWLog(@"error = %@", error.userInfo);
            
            // 返回结果
//            error.userInfo = {
//                error : 此电子邮箱已经被占用。,
//                NSLocalizedDescription : 此电子邮箱已经被占用。,
//                code : 203
//            }
            
            // 最有可能的情况是用户名已经被另一个用户注册，错误代码 202，即 _User 表中的 username 字段已存在相同的值，此时需要提示用户尝试不同的用户名来注册。
            
        }
    }];
}
- (void)numberButtonClicked:(UIButton *)button {
    SWLogFunc;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
