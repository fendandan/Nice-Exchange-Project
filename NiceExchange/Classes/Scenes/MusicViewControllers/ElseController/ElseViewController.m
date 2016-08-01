//
//  ElseViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/24.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "ElseViewController.h"
#import "ElseTableViewCell.h"
#import "SWUserDetailViewController.h"
#import "SWshowViewController.h"
#import "SWFridenSharOnTableViewCell.h"

@interface ElseViewController ()

<
  UITableViewDataSource,
  UITableViewDelegate,
  ElseTableViewCellDelegate
>
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ElseViewController

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ElseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ElseTableViewCell_Identifiter];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ElseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ElseTableViewCell_Identifiter forIndexPath:indexPath];
    cell.delegate = self;
    
    if ([self.rootVC.followArray containsObject:[SWLcAvUSer currentUser]]) {
        cell.attentionBtn.selected = YES;
    }
    
    SWActivityList *activity = self.dataArray[indexPath.row];
    
    cell.subHeadLabel.text = activity.subhead;
    
    cell.titleLabel.text = activity.title;
    [cell.BackGroundImageView setImageWithURL:[NSURL URLWithString:activity.titleImage.url]];
    
    
    
    SWLcAvUSer *u = [SWLcAvUSer objectWithClassName:@"_User" objectId:activity.createBy.objectId];
    [u fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
        SWLcAvUSer *user = (SWLcAvUSer *)object;
        if (user.displayName) {
            [cell.userNameBtn setTitle:activity.createBy.displayName forState:(UIControlStateNormal)];
        }else {
            [cell.userNameBtn setTitle:activity.createBy.username forState:(UIControlStateNormal)];
        }
        
        [cell.titleImageView setImageWithURL:[NSURL URLWithString:user.userImage.url]];
        
    }];
    

    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 200;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ElseTableViewCell *cell = (ElseTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    
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
    AVQuery *Q1 = [SWActivityList query];
    [Q1 addDescendingOrder:@"createdAt"]; // 按时间 新到老
    AVQuery *Q2 = [SWActivityList query];
    [Q2 includeKey:@"createBy"];
    AVQuery *Q3 = [SWActivityList query];
    Q3.limit = 20;
    
    
    AVQuery *q1 = [SWActivityList query];
    [q1 whereKey:@"label" equalTo:@"闲聊"];
    AVQuery *q2 = [SWActivityList query];
    [q2 whereKey:@"label" equalTo:@"文艺"];
    AVQuery *q3 = [SWActivityList query];
    [q3 whereKeyDoesNotExist:@"label"];
    AVQuery *qq = [AVQuery orQueryWithSubqueries:[NSArray arrayWithObjects:q1, q2, q3, nil]];
    
    AVQuery *aQ = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:Q1, Q2, Q3, qq, nil]];
    [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //        SWActivityList *acc = objects[16];
        //        SWLog( @" acc %@",acc.titleImage.url);  // 测试 图片链接
        for (SWActivityList *a in objects) {
            
            [self.dataArray addObject:a];
//            SWLog(@" === ==== == %@",a.createBy.userImage.url);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}




//关注的点击事件
- (void)elseTableViewCellAttentionBtnClickend:(ElseTableViewCell *)cell
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
- (void)elseTableViewCellUserNameBtnClikend:(ElseTableViewCell *)cell
{
    
    SWUserDetailViewController *swVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:swVC animated:YES];
    
}



//用户头像点击事件
- (void)elsetableViewCellUserimageViewClikend:(ElseTableViewCell *)cell
{
    SWUserDetailViewController *swVC = [SWUserDetailViewController new];
    
    [self.navigationController pushViewController:swVC animated:YES];
    
}



//收藏点击事件
- (void)elseTableViewCollectBtnClikend:(ElseTableViewCell *)cell
{
    SWshowViewController *showVC = [[SWshowViewController alloc] init];
    [self.navigationController pushViewController:showVC animated:YES];
}


//参与的点击事件
- (void)elseTableViewparticipationBtnClikend:(ElseTableViewCell *)cell
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
