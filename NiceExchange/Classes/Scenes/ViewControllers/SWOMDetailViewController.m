//
//  SWOMDetailViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/8/1.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWOMDetailViewController.h"

@interface SWOMDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *omTAbleView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation SWOMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.omTAbleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 103)];
    self.omTAbleView.delegate = self;
    self.omTAbleView.dataSource = self;
    [self.omTAbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"OMCell"];
    [self.view addSubview:self.omTAbleView];
    
    [self requestData];
}
- (void)requestData {
    self.dataArray = [NSMutableArray array];
    
    AVQuery *avQ = [AVQuery queryWithClassName:@"OfficialMessage"];
    //    [avQ whereKey:@"createdAt" greaterThanOrEqualTo:[self getMarkWithKey:@"OfficialMessage" marcoPath:@"Message"]];
    [avQ whereKey:@"createdAt" greaterThanOrEqualTo:[self getMarkWithKey:@"OfficialMessage" marcoPath:@"Message"]];
    [avQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.dataArray addObjectsFromArray:objects];
        [self.omTAbleView reloadData];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    //    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OMCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AVObject *ob = self.dataArray[indexPath.row];
    cell.textLabel.text = [ob objectForKey:@"message"];
    
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
