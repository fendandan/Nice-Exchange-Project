//
//  SWLoginViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWLoginViewController.h"

@interface SWLoginViewController ()

@property (strong, nonatomic) SWCertificationView *lrView;

@end

@implementation SWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLoginView];
}

- (void)createLoginView {
    self.lrView = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 2 / 3)];
    [self.view addSubview:self.lrView];
    [self addButton];
    if (self.isMod) {
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 60)];
        headview.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:headview];
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(10, 30, 60, 40);
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicak:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
        
    }

}
- (void)buttonClicak:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addButton {
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lButton.frame = CGRectMake(kScreenWidth / 6, kScreenHeight * 2 / 3 - 74, kScreenWidth * 2 / 3, 38);
    lButton.backgroundColor = [UIColor grayColor];
    //    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Selected",imageName]] forState:UIControlStateSelected];
    [lButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    lButton.layer.cornerRadius = 5;
    lButton.layer.borderWidth = 0.5;
    lButton.layer.borderColor = kBorderCGColor;
    
    [lButton setTitle:@"登录" forState:UIControlStateNormal];
    lButton.titleLabel.font = [UIFont systemFontOfSize:26];
    lButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [lButton setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [lButton setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    
    UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rButton.frame = CGRectMake(kScreenWidth * 5 / 6 - 72, kScreenHeight * 2 / 3 - 35, 72, 12);
    [rButton addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [rButton setTitle:@">>忘记密码" forState:UIControlStateNormal];
    rButton.titleLabel.font = [UIFont systemFontOfSize:12];
    rButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rButton setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateHighlighted];
    
    
    [self.view addSubview:lButton];
    [self.view addSubview:rButton];
    
    
}

- (void)loginButtonClicked:(UIButton *)button {
    SWLogFunc;
    // 登录
    [AVUser logInWithUsernameInBackground:self.lrView.userNameTextField.text password:self.lrView.passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            SWLog(@"use3r = %@", user);
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            SWLog(@"error = %@", error.userInfo);
            
            NSNumber *one = error.userInfo[@"code"];
            NSString *two = one.stringValue;
            
            // 如果在 15 分钟内，同一个用户登录失败的次数大于 6 次，该用户账户即被云端暂时锁定，此时云端会返回错误码 {"code":1,"error":"登录失败次数超过限制，请稍候再试，或者通过忘记密码重设密码。"}
            if ([two isEqualToString:@"1"]) {
                SWLog(@"%@", error.userInfo[@"error"]);
            }
            
            [self aalertViewShowWithMessage:error.userInfo[@"error"] title:@"确定" otherTitle:nil tag:0000];
            // 不匹配
//            error = {
//                error : The username and password mismatch.,
//                NSLocalizedDescription : The username and password mismatch.,
//                code : 210
//            }

            
        }
    }];
}
- (void)numberButtonClicked:(UIButton *)button {
    SWLogFunc;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
