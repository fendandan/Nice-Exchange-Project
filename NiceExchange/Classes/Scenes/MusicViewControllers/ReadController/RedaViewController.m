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
    
    
    SWActivityList *activity = [SWActivityList object];
    activity.title = @"守候"; // 标题
    activity.content = @"我跟陈心台之间的关系，有着笨拙的开始。高中入学军训的第一天，我因练习五分钟站姿时开小差被教官罚做仰卧起坐50个，就在我数到49的时候，我被一个温柔的声音停驻了呼吸。那个声音说，那谁，教官让你归队。我抬头一看，是一个扎着双马尾的女生，应该是隔壁班的，因为我们班跟隔壁班组成一个方阵，而且我可以确定我在我们班从来没有见过这个女生。我说，我不叫那谁。我叫贺新凉。她说，哦。贺新凉，教官让你归队。你不需要继续做仰卧起坐了。我说，可我还差一个就做完了呀。她说，教官让你立即归队。我说，你告诉我你叫什么名字，我就归队。她说，反正我告诉你了，教官罚你再做50个不要怪我！说完，她就扭头走了，留下我一个人躺在草地上，凝望着天空那朵漂浮不定的云。微风拂过，云层汇聚又分离，我看着这躁动不安的云朵傻笑着，听到远处有人在呼唤我的名字，立马开始了整个青春的兵荒马乱。后来，教官没继续罚我仰卧起坐50个，而是让我绕着操场跑了10圈。而那个监督我的人，也还是那个扎着双马尾的女生。我说，为什么教官让你监督我呀？她说，我身体不舒服。我很好奇，你怎么了？她说，没事。就是不能训练。我哈哈大笑，你是不是大姨妈来了？她没说话。我也不知道我该继续说些什么。这尴尬的场面是被教官挽救的，他从我身后突然冒出来，然后给我一个限时的奖励，我立马消失在双马尾的眼前。那天晚上，我躺在宿舍的床上，俨然一副腰酸背痛的二级残疾模样。我有的没的扯些跟白天相关的话题，然后终于说出我最想说出口的话:你们知道白天那个监督我罚跑的女生是谁吗？好在宿舍的哥们尚未具备发达的八卦细胞，只是回答了一句“应该是隔壁班的，不知道叫什么名字”，然后我身残志坚地陪他们开始了那段时间无人监管的扑克游戏。第二天，我还是知道了双马尾的名字。训练的时候，教官对着第一排女生说了一句：陈心台，你今天身体能训练了吗？我不知道陈心台说了什么还是点了点头什么都没说，当时我在心中默念了三遍这个名字：陈心台，然后得意地跟天上的浮云眨了眨眼。说实话，陈心台长得并不是很漂亮，而且她有点胖。对。陈心台是个胖子，不折不扣的一个胖子，只是她胖得讨巧，再加上她的双马尾倒也有几分可爱的模样几分而已，不值一提。我清楚地告诉自己，我不喜欢陈心台。我只是好奇她的双马尾以及她不可一世的嚣张——“反正我告诉你了，教官罚你再做50个不要怪我”"; // 内容
    activity.subhead = @"我不能丢了你"; // 副标题
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"shouhou.jpg"], 0.5);
    AVFile *file = [AVFile fileWithName:@"title.jpg" data:data]; // 图片
    [activity setObject:file forKey:@"titleImage"];
    activity.rule = @"一起聊聊"; // 规则
    activity.label = @"心情"; // 标签
    activity.point = [AVGeoPoint geoPointWithLatitude:39.6 longitude:40]; // 坐标
    
    activity.markC = @0; // 收藏数累计，默认0
    [activity setObject:[SWLcAvUSer currentUser] forKey:@"createBy"]; // 发布者
    [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        SWLog(@"error %@",error);
        if (succeeded) {
            SWLog(@"succeeded %d",succeeded);
        }
    }];
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
