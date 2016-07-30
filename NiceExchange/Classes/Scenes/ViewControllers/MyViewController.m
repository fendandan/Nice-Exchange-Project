//
//  MyViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MyViewController.h"
#import "SWFocusonViewController.h"
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
    
    
    // 保存count表关联 ---- 累。。。
    if (![SWLcAvUSer currentUser].count && [SWLcAvUSer currentUser]) {
        AVQuery *cQ = [AVQuery queryWithClassName:@"Count"];
        [cQ whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
        [cQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count != 0) {
                SWCount * c = objects[0];
//            SWLog(@"cccc cccccccc ccc %@",c);
                [[SWLcAvUSer currentUser] setObject:c forKey:@"count"];
                [[SWLcAvUSer currentUser] saveInBackground];
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.userTableView registerNib:[UINib nibWithNibName:@"SWusrTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWusrTableViewCell"];
    
    [self.userTableView registerNib:[UINib nibWithNibName:@"SWpratTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWpratTableViewCell"];
    
    [self.userTableView registerNib:[UINib nibWithNibName:@"SWcollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWcollectionTableViewCell"];

    
    
    
    
    //
    self.title = @"我的";
    
    self.dataArray = @[@"d", @"sgf", @"sg"].mutableCopy;
    [self createTableView];
    
    
//    SWActivityList *activity = [SWActivityList object];
//    activity.title = @"25岁，从来没谈过恋爱是不是很奇葩"; // 标题
//    activity.content = @"和许多人聊过天，其中包含：新认识的同事、新认识的朋友等等。在问道你的年龄好一定会问的问题就是你有没有男朋友，说完没有后就会问你处没处过对象，说没有后大家就会觉得不可思议，觉得很惊讶。所以现在每当和别人谈论到这里，我都觉得特别特别丢人，真想挖个地缝钻下去。不知道有没有和我有同感的。好难过"; // 内容
//    activity.subhead = @""; // 副标题
//    NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"xxxcx.jpg"]);
//    AVFile *file = [AVFile fileWithName:@"title.jpg" data:data]; // 图片
//    [activity setObject:file forKey:@"titleImage"];
//    activity.rule = @"一起聊聊"; // 规则
//    activity.label = @"三观"; // 标签
//    activity.point = [AVGeoPoint geoPointWithLatitude:39.6 longitude:40]; // 坐标
//    
//    activity.markC = @0; // 收藏数累计，默认0
//    [activity setObject:[SWLcAvUSer currentUser] forKey:@"createBy"]; // 发布者
//    [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        SWLog(@"error %@",error);
//        if (succeeded) {
//            SWLog(@"succeeded %d",succeeded);
//        }
//    }];
    
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
        
//        // 回传count并保存
//        rVC.rCount = ^(SWCount *count){
//            [[SWLcAvUSer currentUser] setObject:count forKey:@"count"];
//            [[SWLcAvUSer currentUser] saveInBackground];
//        };
        
        
        
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
            cell.portraitView.backgroundColor = [UIColor magentaColor];
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
                cell.titlelabel.text = @"我发起的";
                break;
            case 1:
                cell.titlelabel.text = @"我参与的";
                break;
            case 2:
                cell.titlelabel.text = @"我收藏的";
                break;
                
            default:
                break;
        }

        
        
        if ([SWLcAvUSer currentUser]) {
            // 查询计数数量
            AVQuery *countQ = [AVQuery queryWithClassName:@"Count"];
            [countQ whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
            [countQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects.count != 0) {
                    SWCount *count = objects[0];
                    
                    switch (indexPath.row) {
                        case 0:
                            cell.numberlabel.text = count.activityC.stringValue;
                            break;
                        case 1:
                            cell.numberlabel.text = count.commentC.stringValue;
                            break;
                        case 2:
                            cell.numberlabel.text = count.markC.stringValue;
                            break;
                            
                        default:
                            break;
                    }
                    
                 
                }
                
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
        
        SWFocusonViewController *swFocusonVC = [[SWFocusonViewController  alloc]init];
        
        switch (indexPath.row) {
            case 0:
  
                swFocusonVC.RequestData = RequestDataInitiateRequest;
             
               // NSLog(@"0");
                break;
             
                case 1:
                 {
                        // NSLog(@"1");
                      
            swFocusonVC.RequestData  =    RequestDataParticipate;
                     
                    }
                
                break;
                
                case 2:
                    //NSLog(@"2");
                swFocusonVC.RequestData = RequestDataMark;
                 break;
                
            default:
                break;
        }
        
        [self.navigationController pushViewController:swFocusonVC animated:YES];

    }else {
        

   
    
       }
    
    
    
}





#pragma  mark --- UserIfonCellDelegate
- (void)userIfonTableViewLoginButtonClicked:(SWUserInfoCell *)cell {
    SWLogFunc;
    if (!self.currentUser) {
        SWLoginViewController *lVC = [SWLoginViewController new];
        [self.navigationController pushViewController:lVC animated:YES];
        
    }else {
        SWAboutMeViewController *amVC = [SWAboutMeViewController new];
        [self.navigationController pushViewController:amVC animated:YES];
        
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
