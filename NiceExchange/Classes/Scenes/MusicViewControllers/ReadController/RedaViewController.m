//
//  RedaViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "RedaViewController.h"
#import "ReadTableViewCell.h"
#import "SWUserDetailViewController.h"
#import "SWshowViewController.h"

@interface RedaViewController ()
<
   UITableViewDataSource,
   UITableViewDelegate,
   ReadTableViewCellDelegate
>

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation RedaViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.rootVC.swTabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.dataArray = [NSMutableArray array];
    [self requestData];
    [self addTableView];
    
}

- (void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 114) style:(UITableViewStylePlain)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"ReadTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ReadTableViewCell_Identifiter];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReadTableViewCell_Identifiter forIndexPath:indexPath];
    
    cell.delegate = self;
    
    if ([self.rootVC.followArray containsObject:[SWLcAvUSer user]]) {
        cell.attentionBtn.selected = YES;
    }
    
    SWActivityList *activity = self.dataArray[indexPath.row];
    
    cell.titleLabel.text = activity.title;
    [cell.BackGroundImageView setImageWithURL:[NSURL URLWithString:activity.titleImage.url]];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)requestData {
    // 查询活动
    AVQuery *aQ = [SWActivityList query];
    [aQ addDescendingOrder:@"createdAt"]; // 按时间 新到老
    aQ.limit = 20;
    //    [aQ whereKey:@"creatBy" equalTo:[AVUser currentUser]];
    [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //        SWActivityList *acc = objects[16];
        //        SWLog( @" acc %@",acc.titleImage.url);  // 测试 图片链接
        for (SWActivityList *a in objects) {
            SWActivityList *ac = a;
            [self.dataArray addObject:ac];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark --- ReadTableViewCellDelegate
- (void)readTableViewPlayBtnClickend:(ReadTableViewCell *)cell
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    SWLog(@"indexPath %@",indexPath);
    // suppose we have a user we want to follow
    SWActivityList *activity = self.dataArray[indexPath.row];
    
    if (cell.attentionBtn.selected == YES) {
        
        UIAlertController *uialert = [UIAlertController alertControllerWithTitle: nil message:@"不再关注此用户" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
// -------------------------------------------------------------
            [[SWLeanCloudManager shareManager] lcToCancelFollowOtherUserWithActivityList:activity];
            [SWLeanCloudManager shareManager].UIFBlock = ^{
                cell.attentionBtn.selected = NO;
                [self.rootVC.followedArray removeObject:activity.createBy];
                [self.tableView reloadData];
            };
        
        }];
        
        [uialert addAction:action1];
        [uialert addAction:action2];
        
        [self presentViewController:uialert animated:YES completion:nil];
        
        
    }else{
        
// -------------------------------------------------------------
        [[SWLeanCloudManager shareManager] lcToFollowOtherUserWithActivityList:activity];
        [SWLeanCloudManager shareManager].UIFBlock = ^{
            cell.attentionBtn.selected = YES;
            [self.rootVC.followedArray addObject:activity.createBy];
            [self.tableView reloadData];
        };
        
        
    }
    
}




//点击title
- (void)readtableviewUserNameBtnClickend:(ReadTableViewCell *)cell
{
    
    SWUserDetailViewController *usweVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:usweVC animated:YES];
    
    
}






//点击头像
- (void)readTableViewPlayImageViewClickend:(ReadTableViewCell *)cell
{
    
    cell.ImageView.userInteractionEnabled = YES;
    
    SWUserDetailViewController *usweVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:usweVC animated:YES];
    
}




//cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWshowViewController *swshowVC = [SWshowViewController new];
    
    [self.navigationController pushViewController:swshowVC animated:YES];
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
