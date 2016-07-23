//
//  SWFocusonViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWFocusonViewController.h"
#import "SWFridenSharOnTableViewCell.h"
#import "SWJoinTableViewCell.h"
#import "SWshowViewController.h"
#import "SWUserDetailViewController.h"
#import "SWUserDetailViewController.h"
#import "SWTableViewController.h"
@interface SWFocusonViewController ()<UITableViewDelegate,UITableViewDataSource,FriendiconDelegate,JoinDelegate>



@end

@implementation SWFocusonViewController

-(void)viewWillAppear:(BOOL)animated {
    
    
    self.rootVC.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注";
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height - 49) style:(UITableViewStylePlain)];
    tableview.delegate = self;
    tableview.dataSource = self;
    //    [tableview registerClass:[SWFridenSharOnTableViewCell class] forCellReuseIdentifier:@"FocusCell"];
    [tableview registerNib:[UINib nibWithNibName:@"SWFridenSharOnTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FridenSharOnCell"];
    
    [tableview registerNib:[UINib nibWithNibName:@"SWJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JoinCell"];
    
    [self.view addSubview:tableview];
    
    //右上方添加好友按钮
    [self addRightButtonItem];
    
    //去除出分割线
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
}
-(void)onJoinClick {
    
    SWUserDetailViewController *usrVC = [[SWUserDetailViewController alloc]init];
    
    [self.navigationController pushViewController:usrVC animated:YES];
}
-(void)onClick {
    
    SWUserDetailViewController *usrVC = [[SWUserDetailViewController alloc]init];
    
    [self.navigationController pushViewController:usrVC animated:YES];
    
    NSLog(@"11");
}
//右上方添加好友按钮
-(void)addRightButtonItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+找好友" style:(UIBarButtonItemStylePlain) target:self action:@selector(addFirends:)];
}
//ButtonItem点击方法
-(void)addFirends:(UIBarButtonItem *)addFriends {
    
    SWTableViewController *tableVC = [SWTableViewController new];
    
    [self.navigationController pushViewController:tableVC animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        
        SWFridenSharOnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FridenSharOnCell"];
        cell.friendDelegate = self;
        return cell;
    }else if (indexPath.row == 1){
        
        
        
        SWJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinCell"];
        cell.joinDelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.UdetailL.hidden = YES;
        
        return cell;
    }
    
    SWJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.joinDelegate = self;
    cell.detailImage.hidden = YES;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 280;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWshowViewController *showVC = [[SWshowViewController alloc]init];
    
    [self.navigationController  pushViewController:showVC animated:YES];
    self.rootVC.swTabBar.hidden = YES;
    
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
