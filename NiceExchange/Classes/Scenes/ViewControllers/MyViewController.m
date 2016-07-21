//
//  MyViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource, UITableViewDelegate, UserIfonCellDelegate>

@property (strong, nonatomic) UITableView *userTableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

static NSString * const SWUserInfoCell_Identifiter = @"SWUserInfoCell_Identifiter";
static NSString * const SWTableViewCell_Identifiter = @"SWTableViewCell_Identifiter";

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self addNavigationBarButtonItem];
    [self.userTableView reloadData];
    // tabbar的显示与隐藏
    self.rootVC.swTabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"我的";
    
    self.dataArray = @[@"d", @"sgf", @"sg"].mutableCopy;
    [self createTableView];
    
    // 个人信息设置
//    SWLcAvUSer * user = [SWLcAvUSer currentUser];
//    user.displayName = @"小助手";
//    [user saveInBackground];
    
}

- (void)createTableView {
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.userTableView.scrollEnabled = NO;
    [self.userTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.userTableView registerClass:[SWUserInfoCell class] forCellReuseIdentifier:SWUserInfoCell_Identifiter];
    [self.userTableView registerClass:[SWTableViewCell class] forCellReuseIdentifier:SWTableViewCell_Identifiter];
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.view addSubview:self.userTableView];
    
}

- (void)addNavigationBarButtonItem {
    if (self.currentUser) {
        UIBarButtonItem *rightBI = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setUserInfo:)];
        self.navigationItem.rightBarButtonItem = rightBI;
    }else {
        UIBarButtonItem *rightBI = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(setUserInfo:)];
        self.navigationItem.rightBarButtonItem = rightBI;
    }
    
}
// item点击方法
- (void)setUserInfo:(UIBarButtonItem *)barButtonItem {
    if (self.currentUser) {
        SWSettingsViewController *sVC = [[SWSettingsViewController alloc] init];
        [self.navigationController pushViewController:sVC animated:YES];
    }else {
        SWRegisterViewController *rVC = [[SWRegisterViewController alloc] init];
        [self.navigationController pushViewController:rVC animated:YES];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
#pragma mark ---- UITableViewDataSource - @required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1) {
        return self.dataArray.count;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SWUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:SWUserInfoCell_Identifiter forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self; // 代理
        if (!self.currentUser) {
            cell.userNameLabel.hidden = YES;
            cell.userInfoView.hidden = YES;
            [cell.loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
            cell.portraitView.image = nil;  // // // // // // // // //
            cell.portraitView.center = CGPointMake(kScreenWidth / 2, kScreenWidth / 6);
            cell.loginButton.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(cell.portraitView.frame) + 20);
        }else {
            cell.portraitView.center = CGPointMake(kScreenWidth / 6, kScreenWidth / 6);
            cell.loginButton.center = CGPointMake(kScreenWidth / 2, cell.portraitView.center.y + 10);
            cell.userNameLabel.hidden = NO;
            cell.userInfoView.hidden = NO;
            [cell.loginButton setTitle:@"编辑资料" forState:UIControlStateNormal];
            cell.avUser = [SWLcAvUSer currentUser];
        }
        cell.backgroundColor = kImageColor;
        return cell;
    }else if (indexPath.section == 1){
        SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWTableViewCell_Identifiter forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:
                cell.titlelabel.text = @"我的";
                break;
            case 1:
                cell.titlelabel.text = @"我的活动";
                break;
            case 2:
                cell.titlelabel.text = @"我的收藏";
                break;
                
            default:
                break;
        }
        
        if ([SWLcAvUSer currentUser]) {
            // 查询计数数量
            AVQuery *countQ = [AVQuery queryWithClassName:@"Count"];
            [countQ whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
            [countQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                SWCount *count = objects[0];
                cell.numberlabel.text = [count.followC stringValue];
                SWLog(@"%@",count);
            }];
        }
        
        return cell;
    }else {
        SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWTableViewCell_Identifiter forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)  {
        return 180;
    }
    return 60;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return nil;
        case 1:
            return @"我的";
        case 2:
            return @"订单";
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
    
    }else if (indexPath.section == 1) {
//        UIImage *i = [UIImage imageNamed:@"Book"];
//        NSData *imageData = UIImagePNGRepresentation(i);
//        AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"ActivityList"];// 构建对象
//        [todoFolder setObject:@"工作+" forKey:@"name"];// 设置名称
//        [todoFolder setObject:@1 forKey:@"priority"];// 设置优先级
////        [todoFolder setObject:imageData forKey:@"image"];
//        [todoFolder saveInBackground];// 保存到云端
        
//        AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"game"];// 构建对象
//        [todoFolder setObject:@"工作" forKey:@"name"];// 设置名称
//        [todoFolder setObject:@1 forKey:@"priority"];// 设置优先级
//        [[SWLeanCloudManager shareManager] lcSaveObjectWithAVObject:todoFolder];
        
        // 保存
//        AVObject *game= [AVObject objectWithClassName:@"Game"];
//        [game setObject:@"5656" forKey:@"P"];
//        [game setObject:[AVUser currentUser] forKey:@"createdBy"];
//        [game incrementKey:@"df"];
//        [[SWLeanCloudManager shareManager] lcSaveObjectWithAVObject:game];
//        SWLog(@"%@", [AVUser currentUser]);
        
    }else {
//        // 根据Id查询实例对象的数据
////        AVQuery *query = [AVQuery queryWithClassName:@"ActivityList"];
////        [query getObjectInBackgroundWithId:@"5788ab127db2a2005ce0edc6" block:^(AVObject *object, NSError *error) {
////            // object 就是 id 为 558e20cbe4b060308e3eb36c 的 Todo 对象实例
////            UIImage *i = [UIImage imageWithData:object[@"image"]];
////            SWLog(@"%@",i);
////            SWLog(@"%@",error);
////        }];
//        
//        // 批量(初体验-- 慢，错)
//        [[SWLeanCloudManager shareManager] selectObjectsWithClassName:@"ActivityList" successRespon:^(AVObject *obj, NSArray *arrays) {
//            SWLog(@"%@",arrays[0]);
//        } failureRespon:^(NSError *error) {
//            SWLog(@"%@",error);
//        }];
        
//        [[SWLeanCloudManager shareManager] lcSelectObjectsWithClassName:@"_User" successRespon:^(AVObject *obj, NSArray *arrays) {
//            SWLog(@"%@",arrays);
//        } failureRespon:^(NSError *error) {
//            SWLog(@"%@",error);
//        }];
        
        // 请求
//        AVQuery *gameQuery = [AVQuery queryWithClassName:@"Game"];
////        [gameQuery whereKey:@"createdBy" equalTo:[AVUser currentUser]];
//        [gameQuery whereKey:@"P" equalTo:@"566"];
//        [gameQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            SWLog(@"%@",objects);
//        }];
    }
    
}

#pragma  mark --- UserIfonCellDelegate
- (void)userIfonTableViewLoginButtonClicked:(SWUserInfoCell *)cell {
    SWLogFunc;
    if (!self.currentUser) {
        SWLoginViewController *lVC = [SWLoginViewController new];
        [self.navigationController pushViewController:lVC animated:YES];
    }else {
        
    }
    
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
