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
@interface SWFocusonViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation SWFocusonViewController

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

//右上方添加好友按钮
-(void)addRightButtonItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+找好友" style:(UIBarButtonItemStylePlain) target:self action:@selector(addFirends:)];
}
//ButtonItem点击方法
-(void)addFirends:(UIBarButtonItem *)addFriends {
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        
        SWFridenSharOnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FridenSharOnCell"];
        return cell;
    }else if (indexPath.row == 1){
    
    
    
    SWJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.UdetailL.hidden = YES;
        
    return cell;
    }
      
        SWJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.detailImage.hidden = YES;
      
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 280;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
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
