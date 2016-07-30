//
//  SWSettingsViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/16.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWSettingsViewController.h"

@interface SWSettingsViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UITableView *settingsTableView;
@property (strong, nonatomic) NSArray *dataArray;

@end

static NSString *const systemCell_Identifiter = @"systemCell_Identifiter";

@implementation SWSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.dataArray = @[@"账号", @"通知设置", @"推送设置", @"修改密码", @"文件存档", @"清除缓存", @"关于"];
    
    self.settingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 103) style:UITableViewStylePlain];
    [self.settingsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:systemCell_Identifiter];
    self.settingsTableView.delegate = self;
    self.settingsTableView.dataSource = self;
    self.settingsTableView.scrollEnabled = NO;
    
    [self.view addSubview:self.settingsTableView];
    [self addButton];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCell_Identifiter forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
//    cell.backgroundColor = kitColor;
    if (indexPath.row == 5) {
        UILabel *sche = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width - 100, 5, 90, cell.contentView.frame.size.height - 10)];
        sche.font = [UIFont systemFontOfSize:20.0];
        sche.text = [NSString stringWithFormat:@"%0.1fM", self.cacheFileSize];
        [cell.contentView addSubview:sche];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
      [self.navigationController pushViewController:[[SWNotifcationSettingViewController alloc] init] animated:YES];
    }else if (indexPath.row == 3) { // ??  && [SWLcAvUSer currentUser]
        SWRSPViewController *rspVC = [[SWRSPViewController alloc] init];
        [self presentViewController:rspVC animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 5 && self.cacheFileSize) {
        [self aalertViewShowWithMessage:@"确认清除缓存？" title:@"取消" otherTitle:@"确定" tag:1034];
    }
}


- (void)addButton {
    UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rButton.frame = CGRectMake(0, 0, 60, 15);
    rButton.center = CGPointMake(kScreenWidth / 2, kScreenHeight - 250);
    [rButton addTarget:self action:@selector(SignOutUser:) forControlEvents:UIControlEventTouchUpInside];
    
    [rButton setTitle:@"退出登录" forState:UIControlStateNormal];
    rButton.titleLabel.font = [UIFont systemFontOfSize:12];
    rButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rButton setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateHighlighted];
    
    [self.view addSubview:rButton];
}
// item点击方法
- (void)SignOutUser:(UIBarButtonItem *)barButtonItem {
    [self aalertViewShowWithMessage:@"确认退出登录吗？" title:@"确定" otherTitle:@"取消" tag:1033];
}
#pragma mark --- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1033) {
        // 登出
        [AVUser logOut];  //清除缓存用户对象
        AVUser *currentUser = [AVUser currentUser]; // 现在的currentUser是nil了
        
        // 登录状态为退出登录，未登录
        self.currentUser = [AVUser currentUser];
        [self.settingsTableView reloadData];
    }
    
    if (buttonIndex == 1 && alertView.tag == 1034) {
        [self removeCache];
        [self.settingsTableView reloadData];
    }
}
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    return YES;
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
