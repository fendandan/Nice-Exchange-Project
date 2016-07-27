//
//  SWNotLoggedViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWNotLoggedViewController.h"
#import "SWLoginViewController.h"
#import "SWRegisterViewController.h"
@interface SWNotLoggedViewController ()

@property (nonatomic,strong)UIImageView *headimage;//头像视图默认
@property (nonatomic,strong)UILabel *promptlabel;//提示语
@property (nonatomic,strong)UIButton *loginButton;//登录
@property (nonatomic,strong)UIButton *registerButton;//注册

@end

@implementation SWNotLoggedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpeg"]];
    [self loginClicak];
}

-(void)loginClicak
{
    //初始化
    self.headimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3, self.view.bounds.size.height/9, self.view.bounds.size.width/4, self.view.bounds.size.width/4)];
    self.headimage.image = [UIImage imageNamed:@"1.jpeg"];
    [self.view addSubview:self.headimage];
    self.headimage.layer.masksToBounds = YES;
    self.headimage.layer.cornerRadius = self.headimage.frame.size.height/2;
    self.promptlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.headimage.frame)+20, self.view.bounds.size.width - 40, 60)];
    self.promptlabel.numberOfLines = 0;
    self.promptlabel.text = @"北京野生动物园老虎叼走一个下车的女人后，全国各大城市的中年成功男人纷纷以各种理由，带老婆驾车奔赴北京，他们的计划就是自驾游玩野生动物园，园内游玩途中故意和老婆吵架，刺激老婆下车，然后关上车门；这引起了北京成功男人的强烈不满，他们说目前动物园的老虎连北京的老婆都吃不完，外地的就别来捣乱了";
    [self.view addSubview:self.promptlabel];
    
    [self.promptlabel sizeToFit];
    self.promptlabel.frame = CGRectMake(20, CGRectGetMaxY(self.headimage.frame)+20, self.view.bounds.size.width - 40, 200);
    
    self.loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.loginButton.frame = CGRectMake(50, 400, 150, 80);
    [self.loginButton setTitle:@"前去登录" forState:(UIControlStateNormal)];
    [self.loginButton addTarget:self action:@selector(loginButtonClicak:) forControlEvents:(UIControlEventTouchUpInside)];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height/4;
    [self.view addSubview:self.loginButton];
    self.loginButton.backgroundColor = [UIColor cyanColor];
    self.registerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.registerButton setTitle:@"前去注册" forState:(UIControlStateNormal)];
    [self.registerButton addTarget:self action:@selector(registerButtonClicak:) forControlEvents:(UIControlEventTouchUpInside)];
    self.registerButton.frame = CGRectMake(240, 400, 150, 80);
    self.registerButton.backgroundColor = [UIColor cyanColor];
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = self.registerButton.frame.size.height/4;
    [self.view addSubview:self.registerButton];
    
    
    
}
//登录
-(void)loginButtonClicak:(UIButton *)sender
{
    SWLoginViewController *login =[[SWLoginViewController alloc]init];
    login.isMod = YES;
    [self presentModalViewController:login animated:YES];
}
//注册
-(void)registerButtonClicak:(UIButton *)sender
{
    SWRegisterViewController *regis = [[SWRegisterViewController alloc]init];
    regis.isMod = YES;
   [self presentModalViewController:regis animated:YES];
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
