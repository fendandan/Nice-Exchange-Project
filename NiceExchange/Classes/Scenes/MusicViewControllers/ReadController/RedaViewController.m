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
#import "SWFridenSharOnTableViewCell.h"

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
    
    if (self.rootVC.state == YES) {
        
    }
    
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
    
    SWActivityList *activity = self.dataArray[indexPath.row];
    
    //不明白什么意思
    if ([self.rootVC.followArray containsObject:activity.createBy]) {
        cell.attentionBtn.selected = YES;
    }
    
    cell.subheadingLabel.text = activity.subhead;
    
    cell.titleLabel.text = activity.title;
    [cell.BackGroundImageView setImageWithURL:[NSURL URLWithString:activity.titleImage.url]];
    
    [cell.ImageView setImageWithURL:[NSURL URLWithString:activity.createBy.userImage.url]];
    
    if (activity.createBy.displayName) {
        [cell.UserNameBtn setTitle:activity.createBy.displayName forState:(UIControlStateNormal)];
    }else {
        
        [cell.UserNameBtn setTitle:activity.createBy.username forState:(UIControlStateNormal)];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)requestData {
    // 查询活动
    [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
    AVQuery *aQ = [SWActivityList query];
    [aQ addDescendingOrder:@"createdAt"]; // 按时间 新到老
    [aQ includeKey:@"createBy"];
    aQ.limit = 20;
    //    [aQ whereKey:@"creatBy" equalTo:[AVUser currentUser]];
    [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //        SWActivityList *acc = objects[16];
        //        SWLog( @" acc %@",acc.titleImage.url);  // 测试 图片链接
        for (SWActivityList *a in objects) {
//            SWLog(@"---------------%@", a.createBy.userImage.url);
            [self.dataArray addObject:a];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [GiFHUD dismiss];
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
            [GiFHUD setGifWithImageName:@"pika.gif"];
            [GiFHUD show];
            [LCManager lcToCancelFollowOtherUserWithActivityList:activity completion:^(NSArray *mArray) {
                cell.attentionBtn.selected = NO;
                [self.rootVC.followArray removeObject:activity.createBy];
                [self dudue];
                LCManager.shareManagerB = NO; // 置为可调用状态
            }];
        
        }];
        
        [uialert addAction:action1];
        [uialert addAction:action2];
        
        [self presentViewController:uialert animated:YES completion:nil];
        
        
    }else{
        
// -------------------------------------------------------------
        [GiFHUD setGifWithImageName:@"pika.gif"];
        [GiFHUD show];
        [LCManager lcToFollowOtherUserWithActivityList:activity completion:^(NSArray *mArray) {
            
            cell.attentionBtn.selected = YES;
            [self.rootVC.followArray addObject:activity.createBy];
            [self dudue];
            LCManager.shareManagerB = NO; // 置为可调用状态
            
        }];
    }
}




//点击title
- (void)readtableviewUserNameBtnClickend:(ReadTableViewCell *)cell
{
    cell.ImageView.userInteractionEnabled = YES;
    SWUserDetailViewController *usweVC = [SWUserDetailViewController new];
    
    //根据 cell 获得 indexPatch
    NSIndexPath *indexPatch = [self.tableView indexPathForCell:cell];
    
    SWActivityList *act = self.dataArray[indexPatch.row];
    
    usweVC.userString = act.createBy.objectId;
    
    
    NSLog(@"usweVC%@",usweVC.userString);
    
    [self.navigationController pushViewController:usweVC animated:YES];
}






//点击头像
- (void)readTableViewPlayImageViewClickend:(ReadTableViewCell *)cell
{
    
    cell.ImageView.userInteractionEnabled = YES;
    SWUserDetailViewController *usweVC = [SWUserDetailViewController new];
    
    //根据 cell 获得 indexPatch
    NSIndexPath *indexPatch = [self.tableView indexPathForCell:cell];
    
    SWActivityList *act = self.dataArray[indexPatch.row];
    
    usweVC.userString = act.createBy.objectId;
    
    
    NSLog(@"usweVC%@",usweVC.userString);
    
    [self.navigationController pushViewController:usweVC animated:YES];
    
}






//cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadTableViewCell *cell = (ReadTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    
    SWshowViewController *swshowVC = [[SWshowViewController alloc] init];
    
    SWActivityList *activity = self.dataArray[indexPath.row];
    
    swshowVC.activity = activity;
    
    if (activity.createBy.displayName) {
        swshowVC.string = activity.createBy.displayName;
    }else {
        swshowVC.string = activity.createBy.username;
    }
    
    swshowVC.titlestring = activity.createBy.userImage.url;
    swshowVC.dataImage = cell.BackGroundImageView.image;
    
    
    [self.navigationController pushViewController:swshowVC animated:YES];
    self.rootVC.swTabBar.hidden = YES;
}


-(void)dudue {
    
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        [self requestData];
    }
    
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
