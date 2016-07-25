//
//  SWFocusonViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWFocusonViewController.h"
#import "SWFridenSharOnTableViewCell.h"
#import "SWJoinTableViewCell.h"
#import "SWshowViewController.h"
#import "SWUserDetailViewController.h"
#import "SWUserDetailViewController.h"
#import "SWTableViewController.h"
@interface SWFocusonViewController ()<UITableViewDelegate,UITableViewDataSource,FriendiconDelegate,JoinDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *ztableView;
@property (nonatomic,strong)UIImageView *imageV;
@end


@implementation SWFocusonViewController

-(void)viewWillAppear:(BOOL)animated {
    
    
    self.rootVC.swTabBar.hidden = NO;
    SWLog(@" 00 0000 000 000  %@",self.rootVC.followArray);
    if (self.rootVC.followArray != NULL) {
        [self requestData];
    }else {
        [self performSelector:@selector(requestData) withObject:nil afterDelay:3];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注";
    self.dataArray = [NSMutableArray array];
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 58, 58)];
   self.ztableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 46, self.view.frame.size.width, self.view.frame.size.height - 49) style:(UITableViewStylePlain)];
    self.ztableView.delegate = self;
    self.ztableView.dataSource = self;
    //    [tableview registerClass:[SWFridenSharOnTableViewCell class] forCellReuseIdentifier:@"FocusCell"];
    [self.ztableView registerNib:[UINib nibWithNibName:@"SWFridenSharOnTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FridenSharOnCell"];
    
    [self.ztableView registerNib:[UINib nibWithNibName:@"SWJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JoinCell"];
    
    [self.view addSubview:self.ztableView];
    
    //右上方添加好友按钮
    [self addRightButtonItem];
    
    //去除出分割线
    self.ztableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
   

     
}
#warning 请求数据
-(void)requestData {
    
    // 查询活动
    AVQuery *aQ = [SWActivityList query];
    [aQ addDescendingOrder:@"createdAt"]; // 按时间 新到老
    aQ.limit = 20;
    //    [aQ whereKey:@"creatBy" equalTo:[AVUser currentUser]];
    
//    SWLog(@"22222222222222222%@",self.rootVC.followArray);
    if (self.rootVC.followArray.count == 0) {
        [self performSelector:@selector(requestData) withObject:nil afterDelay:.3];
    }
    for ( SWLcAvUSer *user in  self.rootVC.followArray ) {
      
        
        [aQ whereKey:@"createBy" equalTo:user];
        [aQ includeKey:@"createBy"];
        
        [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            //        SWActivityList *acc = objects[16];
            //        SWLog( @" acc %@",acc.titleImage.url);  // 测试 图片链接
            for (SWActivityList *a in objects) {
                SWActivityList *ac = a;
                [self.dataArray addObject:ac];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
//                SWLog(@"-----------++++ ---- %@",self.dataArray);
                
                [self.ztableView reloadData];
            });
        }];
        
        
    }
    

    

    
}

-(void)onJoinClick {
    
    SWUserDetailViewController *usrVC = [[SWUserDetailViewController alloc]init];
    
    [self.navigationController pushViewController:usrVC animated:YES];
}
-(void)onClick {
    
    SWUserDetailViewController *usrVC = [[SWUserDetailViewController alloc]init];
    
    [self.navigationController pushViewController:usrVC animated:YES];
    
    NSLog(@"11");
}
//右上方添加好友按钮
-(void)addRightButtonItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+找好友" style:(UIBarButtonItemStylePlain) target:self action:@selector(addFirends:)];
}
//ButtonItem点击方法
-(void)addFirends:(UIBarButtonItem *)addFriends {
    
    SWTableViewController *tableVC = [SWTableViewController new];
    
    [self.navigationController pushViewController:tableVC animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == 0) {
//        
//        
//        SWFridenSharOnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FridenSharOnCell"];
//        cell.friendDelegate = self;
//        return cell;
//    }else if (indexPath.row == 1){
//        
//        
//        
//        SWJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinCell"];
//        cell.joinDelegate = self;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.UdetailL.hidden = YES;
//        
//        return cell;
//    }
//    
//    SWJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinCell"];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.joinDelegate = self;
//    cell.detailImage.hidden = YES;
//    
//    return cell;
    

    
    
    SWFridenSharOnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FridenSharOnCell"];
    cell.friendDelegate = self;
    
    SWActivityList *list = self.dataArray[indexPath.row];
    
    if (list.createBy.displayName) {
        cell.FriendName.text =list.createBy.displayName;
    }else {
        cell.FriendName.text =list.createBy.username;
    }
    cell.title.text = list.title;
    [cell.detailImv setImageWithURL:[NSURL URLWithString:list.titleImage.url]];
//    cell.collectNum.text = @"";
//    cell.joinNum.text = @"";
     cell.BJLable.text =  list.label;
    cell.GZlABLE.text = list.rule;
//    [self.imageV setImageWithURL:[NSURL URLWithString:list.createBy.userImage.url]];
//    SWLog(@"iii iiii iiii ii%@", list.createBy.userImage.url);
    AVFile *ff = [AVFile fileWithURL:list.createBy.userImage.url];
    [ff getThumbnail:YES width:200 height:200 withBlock:^(UIImage *image, NSError *error) {
        [cell.Friendicon  setImage:image forState:(UIControlStateNormal)];
    }];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 280;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
       SWFridenSharOnTableViewCell *cell = (SWFridenSharOnTableViewCell *)[self tableView:_ztableView cellForRowAtIndexPath:indexPath];
    SWshowViewController *showVC = [[SWshowViewController alloc]init];
    
    
    SWActivityList *activity = self.dataArray[indexPath.row];
    showVC.activity =  activity ;
    
    if (activity.createBy.displayName) {
       showVC.string = activity.createBy.displayName;
    }else {
        showVC.string = activity.createBy.username;
    }
    showVC.titlestring = activity.createBy.userImage.url;
    showVC.dataImage = cell.detailImv.image;


    [self.navigationController  pushViewController:showVC animated:YES];
    self.rootVC.swTabBar.hidden = YES;
    
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
