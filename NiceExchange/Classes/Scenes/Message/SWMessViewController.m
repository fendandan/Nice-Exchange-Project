//
//  SWMessViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWMessViewController.h"

#import "SWTableViewCell.h"

#import "SWNotLoggedViewController.h"
#define TableviewCell @"TableviewCell"
@interface SWMessViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic,strong)NSMutableArray *imagearray;//消息图标
@property (strong, nonatomic) NSMutableArray *messageArray; // 消息数
@property (strong ,nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSDate *date;

@end

@implementation SWMessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化可变数组
    self.mutableArray = [NSMutableArray arrayWithObjects:@"关注和拉黑",@"沙龙动态",@"评论",@"赞",@"收藏",@"官方通知", nil];
    self.imagearray = [NSMutableArray arrayWithObjects:@"关注和拉黑",@"沙龙动态",@"评论",@"赞",@"收藏",@"官方通知", nil];
    self.messageArray = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", @"0", @"0", nil];
  self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64-49) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    
   [self.tableview registerClass:[SWTableViewCell class] forCellReuseIdentifier:SWTableViewCell_Cell];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
   //设置
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightbarbuttonAction:)];
    
    
    // 发布官方消息
//    AVObject *ob = [AVObject objectWithClassName:@"OfficialMessage"];
//    [ob setObject:@"今天开始公测，期待大家的反馈！" forKey:@"message"];
//    [ob saveInBackground];
    
    SWLog(@"=== ===== ==== === === %@", self.documentPath);
    if (![self getMarkWithKey:@"xxoo" marcoPath:@"Message"]) {
        
//        //时区转换，取得系统时区，取得格林威治时间差秒
//        NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
//        NSLog(@"%f",timeZoneOffset/60.0/60.0);
        _date = [NSDate date];
//        _date = [_date dateByAddingTimeInterval:timeZoneOffset];
        
        NSDictionary *dic = @{@"FocusonMessage":_date, @"ActivityMessage":_date, @"CommentMessage":_date, @"GoodMessage":_date, @"MarkMessage":_date, @"OfficialMessage":_date};
        [self goToSaveK8VWithDicName:@"Message" Dic:dic];
        
        
        
        // 请求消息
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getMessageWithPlist) userInfo:nil repeats:YES];
        
    }else {
        // 请求消息
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getMessageWithPlist) userInfo:nil repeats:YES];
    }
    
}
-(void)rightbarbuttonAction:(UIBarButtonItem *)sender{
    SWLog(@"设置");
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutableArray.count;
//    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点我,我就走了");
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //隐藏cell分割线
    tableView.separatorStyle = NO;
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWTableViewCell_Cell forIndexPath:indexPath];
    cell.iconimage.image = [UIImage imageNamed:self.imagearray[indexPath.row]];
    cell.titlelabel.text = self.mutableArray[indexPath.row];
    cell.numberlabel.text = self.messageArray[indexPath.row];
    return cell;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)getMessageWithPlist {
    
//    SWLogFunc;
    if ([SWLcAvUSer currentUser]) {
        [self getMessageFocuson];
        [self getMessageActivity];
        [self getMessageComment];
        [self getMessageMark];
        [self getMessageOfficial];
    }
    
    
}

#warning ---------- number Select

- (void)getMessageFocuson {
    AVQuery *avQ = [SWFollow query];
    [avQ whereKey:@"createdAt" greaterThanOrEqualTo:[self getMarkWithKey:@"FocusonMessage" marcoPath:@"Message"]];
//    [avQ whereKey:@"to" equalTo:[SWLcAvUSer currentUser]];
    [avQ countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (number > 0) {
            if (self.messageArray[0] != [NSString stringWithFormat:@"%ld", number]) {
                
            self.messageArray[0] = [NSString stringWithFormat:@"%ld", number];
            [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationBottom)];
            }
            
        }
    }];
}
// 我创建的活动的一级评论的更新状况（有多少一级评论更新了）
- (void)getMessageActivity {
    // 构建内嵌查询
    AVQuery *innerQuery = [SWActivityList query];
//    [innerQuery whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
    
    
    // 将内嵌查询赋予目标查询
    AVQuery *query = [SWComment query];
    // 执行内嵌操作
    [query whereKey:@"forActivity" matchesQuery:innerQuery];
    [query whereKey:@"updatedAt" greaterThanOrEqualTo:[self getMarkWithKey:@"ActivityMessage" marcoPath:@"Message"]]; // 早于上次查看时间
    [query whereKeyDoesNotExist:@"forComment"]; // 不存在forC，即为一级评论
    
    [query  countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (number > 0) {
            /////////////
            if (self.messageArray[1] != [NSString stringWithFormat:@"%ld", number]) {
                self.messageArray[1] = [NSString stringWithFormat:@"%ld", number];
                [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:(UITableViewRowAnimationBottom)];
            }
            
        }
    }];
}
// 我的活动有了新评论(一级评论)
- (void)getMessageComment {
    
    // 构建内嵌查询 我创建的活动的相关评论
    AVQuery *innerQuery = [SWActivityList query];
    [innerQuery whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
    
    AVQuery *query = [SWComment query];
    [query whereKey:@"forActivity" matchesQuery:innerQuery];
    [query whereKeyDoesNotExist:@"forComment"]; // 不存在forC，即为一级评论
    [query whereKey:@"createdAt" greaterThanOrEqualTo:[self getMarkWithKey:@"CommentMessage" marcoPath:@"Message"]]; // 早于上次查看时间
    [query  countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (number > 0) {
            /////////////
            if (self.messageArray[2] != [NSString stringWithFormat:@"%ld", number]) {
                self.messageArray[2] = [NSString stringWithFormat:@"%ld", number];
                [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:(UITableViewRowAnimationBottom)];
            }
            
        }
    }];
}

// ------------ ------------------ ------------- -------------

- (void)getMessageMark {
    
    //    // 我创建的活动
    //    AVQuery *q = [SWActivityList query];
    //    [q whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
    
    // 新出现的收藏事件的数量
    AVQuery *avQ = [SWMark query];
    [avQ whereKey:@"createdAt" greaterThanOrEqualTo:[self getMarkWithKey:@"MarkMessage" marcoPath:@"Message"]]; // 早于上次查看时间
    [avQ whereKey:@"markTo" equalTo:[SWLcAvUSer currentUser]]; // 收藏我的
    //    [avQ includeKey:@"activity"];
    
    [avQ countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (number > 0) {
            /////////////
            if (self.messageArray[4] != [NSString stringWithFormat:@"%ld", number]) {
                self.messageArray[4] = [NSString stringWithFormat:@"%ld", number];
                [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:(UITableViewRowAnimationBottom)];
            }
            
        }
    }];
}
- (void)getMessageOfficial {
    AVQuery *avQ = [AVQuery queryWithClassName:@"OfficialMessage"];
//    [avQ whereKey:@"createdAt" greaterThanOrEqualTo:[self getMarkWithKey:@"OfficialMessage" marcoPath:@"Message"]];
    [avQ whereKey:@"createdAt" greaterThanOrEqualTo:[self getMarkWithKey:@"OfficialMessage" marcoPath:@"Message"]];
    [avQ countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
//        SWLog(@" ====== ======= %ld", number);
        if (number > 0) {
            /////////////
            if (self.messageArray[5] != [NSString stringWithFormat:@"%ld", number]) {
                self.messageArray[5] = [NSString stringWithFormat:@"%ld", number];
                [self.tableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:(UITableViewRowAnimationBottom)];
            }
            
        }
    }];
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
