//
//  BaseViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 根视图控制器（tabBarController）
    self.rootVC = (RootViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    
    // 视图控制器view背景色
    self.view.backgroundColor = [UIColor colorWithRed:78/256.0 green:78/256.0 blue:78/256.0 alpha:1.0];
    
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
