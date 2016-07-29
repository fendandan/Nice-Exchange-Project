//
//  MovieViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "SWUserDetailViewController.h"
#import "SWshowViewController.h"
#import "SWFridenSharOnTableViewCell.h"
@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate,movieTableViewCellDelegate>


@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    [self addTableview];
    [self requestData];
}


//添加 tableview
- (void)addTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight - 114) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MovieTableViewCell_Identifiter];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieTableViewCell_Identifiter forIndexPath:indexPath];
    cell.delegate = self;
    
    
    if ([self.rootVC.followArray containsObject:[SWLcAvUSer currentUser]]) {
        cell.attentionBtn.selected = YES;
    }
    
    SWActivityList *activity = self.dataArray[indexPath.row];
    
    cell.subHeadLabel.text = activity.subhead;
    
    cell.titleLabel.text = activity.title;
    [cell.BackGroundImageView setImageWithURL:[NSURL URLWithString:activity.titleImage.url]];
    
    [cell.ImageView setImageWithURL:[NSURL URLWithString:activity.createBy.userImage.url]];
    
    NSLog(@"11%@,00%@",cell.ImageView,activity.createBy.userImage.url);
    
    if (activity.createBy.displayName) {
        [cell.userNameBtn setTitle:activity.createBy.displayName forState:(UIControlStateNormal)];
    }else {
        
        [cell.userNameBtn setTitle:activity.createBy.username forState:(UIControlStateNormal)];
    }
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}




//cell 的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = (MovieTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    
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






- (void)requestData {
    // 查询活动
    AVQuery *aQ = [SWActivityList query];
    [aQ addDescendingOrder:@"createdAt"]; // 按时间 新到老
    [aQ includeKey:@"createBy"];
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




//关注点击事件
-(void)movieTableViewplayBtnClickend:(MovieTableViewCell *)cell
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
            [LCManager lcToCancelFollowOtherUserWithActivityList:activity completion:^(NSArray *mArray) {
                cell.attentionBtn.selected = NO;
                [self.rootVC.followedArray removeObject:activity.createBy];
                [self.tableView reloadData];
                LCManager.shareManagerB = NO; // 置为可调用状态
            }];
            
        }];
        
        [uialert addAction:action1];
        [uialert addAction:action2];
        
        [self presentViewController:uialert animated:YES completion:nil];
        
        
    }else{
        
        // -------------------------------------------------------------
        [LCManager lcToFollowOtherUserWithActivityList:activity completion:^(NSArray *mArray) {
            
            cell.attentionBtn.selected = YES;
            [self.rootVC.followedArray addObject:activity.createBy];
            [self.tableView reloadData];
            LCManager.shareManagerB = NO; // 置为可调用状态
            
        }];
    }
}











//用户名的点击事件
- (void)movieTableViewUserNameBtnClickend:(MovieTableViewCell *)cell
{
    
    SWUserDetailViewController *swVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:swVC animated:YES];
    
}



//用户头像点击事件
- (void)movieTableViewUserImageViewClickend:(MovieTableViewCell *)cell
{

    SWUserDetailViewController *swVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:swVC animated:YES];
    
}



//收藏的点击事件
- (void)movieTableViewCollectBtnClickend:(MovieTableViewCell *)cell
{
    
    SWshowViewController *showVC = [[SWshowViewController alloc] init];
    
    [self.navigationController pushViewController:showVC animated:YES];
}


//参与的点击事件
- (void)movieTableViewparticipationBtnClikend:(MovieTableViewCell *)cell
{
    SWshowViewController *showVC = [[SWshowViewController alloc] init];
    
    [self.navigationController pushViewController:showVC animated:YES];
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
