//
//  RootViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

//
+ (void)initialize {
    
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]};
    NSDictionary *selectAttrs = @{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor blackColor]};
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    NSArray *buttons = @[[self buttonWithImageName:@"Fireworks" title:@"烟花"],[self buttonWithImageName:@"Book" title:@"阅读"],[self buttonWithImageName:@"Picture" title:@"美图"],[self buttonWithImageName:@"User" title:@"我的"]];
    
    SWTabBar *swTabBar = [[SWTabBar alloc] initWithItems:buttons frame:CGRectMake(0, 0, kScreenWidth, 49)];
    UIButton *btn = buttons[0];
    btn.selected = YES;
    [self.tabBar addSubview:swTabBar];
    
}

- (UIButton *)buttonWithImageName:(NSString *)imageName title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Selected",imageName]] forState:UIControlStateSelected];
    //    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    button.titleEdgeInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    
    return button;
}

#pragma mark --- SWTabBarDelegate ---
- (void)swTabBarItemDidClicked:(SWTabBar *)tabBar {
    self.selectedIndex = tabBar.currentSelected;
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