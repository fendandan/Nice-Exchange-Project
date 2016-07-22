//
//  SWAboutMeViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/22.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWAboutMeViewController.h"

@interface SWAboutMeViewController ()

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UITextField *displayNameTF;
@property (strong, nonatomic) UITextField *genderTF;
@property (strong, nonatomic) UITextField *infoTF;

@end

@implementation SWAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    [self addView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addView {
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 3, kScreenWidth / 3)];
    self.imgView.center = CGPointMake(kScreenWidth / 2, kScreenWidth / 3 + 20);
    self.imgView.backgroundColor = kImageColor;
    [self.view addSubview:self.imgView];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 135, 15)];
    infoLabel.text = @"点击头像可重新设置";
    infoLabel.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(self.imgView.frame) + 25);
    [self.view addSubview:infoLabel];
    
    SWCertificationView *infoView = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    infoView.center = CGPointMake(20, CGRectGetMaxY(infoLabel.frame) + 10);
    
    infoView.userNameTextField.placeholder = @"昵称";
    infoView.passwordTextField.placeholder = @"性别";
    self.displayNameTF = infoView.userNameTextField;
    self.genderTF = infoView.passwordTextField;
    
    SWCertificationView *infoViewS = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    infoViewS.userNameTextField.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(infoView.frame) + 10);
    infoViewS.userNameTextField.placeholder = @"介绍";
    self.infoTF = infoViewS.userNameTextField;
    
    [self.view addSubview:infoView];
    [self.view addSubview:self.infoTF];
    
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
