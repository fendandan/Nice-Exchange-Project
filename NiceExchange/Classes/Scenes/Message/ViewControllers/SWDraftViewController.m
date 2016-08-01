//
//  SWDraftViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/29.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWDraftViewController.h"
#import "SWDraftTableViewCell.h"
#import "SWCreationViewController.h"
#import "DataBaseHandle.h"
#import "SWCreationViewController.h"



@interface SWDraftViewController ()<UITableViewDataSource,UITableViewDelegate,SWDraftTableViewCellDelegate>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SWDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    self.dataArray = [[DataBaseHandle shareDataBaseHandle] searchAll];
    
    [self addTableView];
 
}







- (void)addTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWDraftTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SWDraftTableViewCell_Identifiter];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWDraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWDraftTableViewCell_Identifiter forIndexPath:indexPath];
    SWDraftModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    cell.delegate = self;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [backBtn setTitle:@"<返回" forState:(UIControlStateNormal)];
    
    [backBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    backBtn.frame = CGRectMake(10, 20, 50, 30);
    
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
   
    
    [headView addSubview:backBtn];
    
    
    return headView;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 64;
}



- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}







- (void)SWDraftTableViewPlayBtnClickend:(SWDraftTableViewCell *)cell
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认删除草稿" preferredStyle:(UIAlertControllerStyleAlert)];
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        [self.dataArray removeObject:cell.model];
        [[DataBaseHandle shareDataBaseHandle] deleteWithUID:cell.model.ID];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
        [self.tableView reloadData];
        
    }];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
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
