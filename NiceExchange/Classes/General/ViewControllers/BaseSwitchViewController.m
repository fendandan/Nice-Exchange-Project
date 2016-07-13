//
//  BaseSwitchViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseSwitchViewController.h"

@interface BaseSwitchViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UITableView *leftTableView;
@property (strong, nonatomic) UITableView *rightTableView;

@property (strong, nonatomic) NSMutableArray *leftDataArray;
@property (strong, nonatomic) NSMutableArray *rightDataArray;

@end

static NSString * const tableViewSystemCell_Identifiter = @"tableViewSystemCell_Identifiter";

@implementation BaseSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.backgroundColor = [UIColor brownColor];
    self.leftDataArray = @[@"f",@"f"].mutableCopy;
    self.rightDataArray = @[@"f",@"f"].mutableCopy;
    [self settingDoubleTableView];
    self.leftTableView.backgroundColor = [UIColor magentaColor];
    self.rightTableView.backgroundColor = [UIColor brownColor];
}

// 创建两个tableView放到一个scrollView（scrollView父视图是self.view）上
- (void)settingDoubleTableView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight);
    
    self.leftTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    // 协议
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    // 注册
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewSystemCell_Identifiter];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    // 协议
    self.rightTableView.dataSource = self;
    self.rightTableView.dataSource = self;
    // 注册
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewSystemCell_Identifiter];
    
    [self.scrollView addSubview:self.leftTableView];
    [self.scrollView addSubview:self.rightTableView];
    [self.view addSubview:self.scrollView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTableView) {
        return self.leftDataArray.count;
    }else {
        return self.rightDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableViewSystemCell_Identifiter forIndexPath:indexPath];
    
    return cell;
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
