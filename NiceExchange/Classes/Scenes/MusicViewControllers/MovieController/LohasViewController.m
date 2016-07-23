//
//  LohasViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/23.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "LohasViewController.h"
#import "LohasTableViewCell.h"

@interface LohasViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation LohasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    
    [self addtableView];
}



- (void)addtableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 114) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"LohasTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:LohasTableViewCell_Identifiter];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LohasTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LohasTableViewCell_Identifiter forIndexPath:indexPath];
    

    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
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
