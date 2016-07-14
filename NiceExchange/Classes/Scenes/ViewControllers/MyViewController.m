//
//  MyViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *userTableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 回到主控制器时不隐藏
    self.rootVC.swTabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.dataArray = @[@"d", @"sgf", @"sg"].mutableCopy; // 测试数组
    [self createTableView];
}

- (void)createTableView {
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.userTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.view addSubview:self.userTableView];
    
}

#pragma mark ---- UITableViewDataSource - @required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    SWLoginViewController *lVC = [SWLoginViewController new];
    //    [self.navigationController pushViewController:lVC animated:YES];
    
    
    SWRegisterViewController *rVC = [SWRegisterViewController new];
    self.rootVC.swTabBar.hidden = YES;
    [self.navigationController pushViewController:rVC animated:YES];
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
