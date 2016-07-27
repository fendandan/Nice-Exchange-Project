//
//  SWMessViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWMessViewController.h"

#import "SWTableViewCell.h"
#import "SWNotifcationSettingViewController.h"
#import "SWNotLoggedViewController.h"
#define TableviewCell @"TableviewCell"
@interface SWMessViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic,strong)NSMutableArray *imagearray;//消息图标
@end

@implementation SWMessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化可变数组
    self.mutableArray = [NSMutableArray arrayWithObjects:@"关注和拉黑",@"沙龙动态",@"评论",@"赞",@"收藏",@"官方通知", nil];
    self.imagearray = [NSMutableArray arrayWithObjects:@"关注和拉黑",@"沙龙动态",@"评论",@"赞",@"收藏",@"官方通知", nil];
  self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    
   [self.tableview registerClass:[SWTableViewCell class] forCellReuseIdentifier:SWTableViewCell_Cell];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
   //设置
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightbarbuttonAction:)];
    
    
}
-(void)rightbarbuttonAction:(UIBarButtonItem *)sender{
    SWLog(@"设置");
    [self.navigationController pushViewController:[[SWNotifcationSettingViewController alloc] init] animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArray.count;
//    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点我,我就走了");
    SWNotLoggedViewController *notlogged = [[SWNotLoggedViewController alloc]init];
    [self.navigationController pushViewController:notlogged animated:YES];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //隐藏cell分割线
    tableView.separatorStyle = NO;
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWTableViewCell_Cell forIndexPath:indexPath];
    cell.iconimage.image = [UIImage imageNamed:self.imagearray[indexPath.row]];
    cell.titlelabel.text = self.mutableArray[indexPath.row];
    cell.numberlabel.text = @"";
    return cell;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
