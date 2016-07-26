//
//  MoodViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MoodViewController.h"
#import "MoodTableViewCell.h"
#import "SWUserDetailViewController.h"
#import "SWshowViewController.h"

@interface MoodViewController ()
<
  UITableViewDataSource,
  UITableViewDelegate,
  MoodTableViewCellDelegate
>

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MoodViewController

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MoodTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MoodTableViewCell_Identifiter];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MoodTableViewCell_Identifiter forIndexPath:indexPath];
    
    cell.delegate = self;
    
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 200;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWshowViewController *SWshowVC = [SWshowViewController new];
    
    
    [self.navigationController pushViewController:SWshowVC animated:YES];
    
    
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




//关注的点击事件
- (void)moodTableViewAttentionPlayBtnClikend:(MoodTableViewCell *)cell
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
- (void)moodTableViewUserNameBtnClikend:(MoodTableViewCell *)cell
{
    SWUserDetailViewController *swVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:swVC animated:YES];
}


//用户头像的点击事件
- (void)moodTableViewUserNameImageViewPlay:(MoodTableViewCell *)cell
{
    
    SWUserDetailViewController *swVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:swVC animated:YES];
    
}


//收藏点击事件
- (void)moodTableViewCollectBtnClikend:(MoodTableViewCell *)cell
{
    SWshowViewController *showVC = [[SWshowViewController alloc] init];
    
    [self.navigationController pushViewController:showVC animated:YES];
}


//参与的点击事件
- (void)moodTableViewparticipationBtnClikend:(MoodTableViewCell *)cell
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
