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


@interface SWDraftViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SWDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
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
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWDraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWDraftTableViewCell_Identifiter forIndexPath:indexPath];
    
    
    cell.titleLabel.text = self.titleStr;
    
//    cell.timeLabel.text = self.textViewStr;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWCreationViewController *swVC = [SWCreationViewController new];
    
    
    [self dismissViewControllerAnimated:swVC completion:nil];
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
