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
    lButton.layer.borderColor = kBorderColor;
    
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
    [AVUser logInWithUsernameInBackground:self.lrView.userNameTextField.text password:self.lrView.passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            
        } else {
            
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
