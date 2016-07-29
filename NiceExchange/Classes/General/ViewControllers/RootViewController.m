//
//  RootViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "RootViewController.h"
#import "MSGuideView.h"
@interface RootViewController ()<SWTabBarDelegate>

@end

@implementation RootViewController

//
- (void)viewWillAppear:(BOOL)animated {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[UIImage imageNamed:@"222"]];
    [array addObject:[UIImage imageNamed:@"333"]];
    [array addObject:[UIImage imageNamed:@"444"]];
    
    [[MSGuideViewManager sharedInstance]showGuideViewWithImages:array andButtonTitle:@"立即体验" andButtonTitleColor:[UIColor redColor] andButtonBGColor:[UIColor greenColor] andButtonBorderColor:[UIColor blackColor]];
//

    
}
- (void)getFollowInfo {
    AVQuery *followQ = [AVQuery queryWithClassName:@"Follow"];
    
    SWLog(@" ----- -- -- -- - %@", [SWLcAvUSer currentUser]);
    if ([SWLcAvUSer currentUser]) {
        
        
        __weak typeof(self) weakself = self;
        
        [followQ whereKey:@"from" equalTo:[SWLcAvUSer currentUser]];
        [followQ selectKeys:@[@"to"]];
        [followQ includeKey:@"to"];
        [followQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            SWLog(@" followArray error %@",error);
            if (error) {
//                [weakself getFollowInfo];
            }else {
                weakself.followArray = [NSMutableArray array];
                for (SWFollow *follow in objects) {
                    [weakself.followArray addObject:follow.to];
                    
                }
            }
        }];
        
        
        [followQ whereKey:@"to" equalTo:[SWLcAvUSer currentUser]];
        [followQ selectKeys:@[@"from"]];
        [followQ includeKey:@"from"];
        [followQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            SWLog(@" followedArray error %@",error);
            if (error) {
//                [weakself getFollowInfo];
            }else {
                weakself.followedArray = [NSMutableArray array];
                for (SWFollow *follow in objects) {
                    [weakself.followedArray addObject:follow.from];
                }
            }
        }];
        
        //        if (weakself.followArray && weakself.followedArray) {
        //            [[NSNotificationCenter defaultCenter] postNotificationName:@"huahua" object:nil userInfo:nil];
        //        }
        
    }
    
}
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
    
        [self getFollowInfo]; // 获取用户关注信息
     NSArray *buttons = @[[self buttonWithImageName:@"Fireworks" title:@"烟花"],[self buttonWithImageName:@"Picture" title:@"美图"],[self buttonWithImageName:@"Release" title:nil],[self buttonWithImageName:@"Book" title:@"阅读"],[self buttonWithImageName:@"User" title:@"我的"]];
    
  self.swTabBar = [[SWTabBar alloc] initWithItems:buttons frame:CGRectMake(0, kScreenHeight - 49  , kScreenWidth, 100)];
  self.swTabBar.swDelegete = self; // 代理
    

    UIButton *btn = buttons[0];
    btn.selected = YES;
    self.tabBar.hidden = YES;
    [self.view addSubview: self.swTabBar];
    
  
    SWNavigationViewController *swNVCfir = [[SWNavigationViewController alloc] initWithRootViewController:[MusicViewController new]];
    SWNavigationViewController *swNVCsec = [[SWNavigationViewController alloc] initWithRootViewController:[SWMessViewController new]];
    SWNavigationViewController *swNVCThr = [[SWNavigationViewController alloc] initWithRootViewController:[SWFocusonViewController new]];
    SWNavigationViewController *swNVCFou = [[SWNavigationViewController alloc] initWithRootViewController:[MyViewController new]];
    SWNavigationViewController *swNVCFive = [[SWNavigationViewController alloc] initWithRootViewController:[SWCreationViewController new]];
    
    self.viewControllers = @[swNVCfir,swNVCThr,swNVCFive,swNVCsec,swNVCFou];

}

// 创建button
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
    button.titleEdgeInsets = UIEdgeInsetsMake(46, 0, 0, 0);
    [self.tabBar addSubview:button];
    return button;
}

#pragma mark --- SWTabBarDelegate ---
- (void)swTabBarItemDidClicked:(SWTabBar *)tabBar {
    
    self.selectedIndex = self.swTabBar.currentSelected;
}
-(void)swMessTabBarItemDidClicked:(SWTabBar *)sender
{
    if ([SWLcAvUSer currentUser]) {
        SWCreationViewController *swcr =[SWCreationViewController new];
        [self presentViewController:swcr animated:YES completion:nil];
    }else {
        SWNotLoggedViewController *notlogged = [[SWNotLoggedViewController alloc]init];
        [self.navigationController pushViewController:notlogged animated:YES];
    }
   
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
