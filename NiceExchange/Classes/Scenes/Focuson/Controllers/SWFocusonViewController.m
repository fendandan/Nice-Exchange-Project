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
//    if (self.rootVC.followArray.count == 0) {  // 
//        switch (self.RequestData) {
//            case RequestDataFoucesRequest:
//                [self requestData]; //
//                break;
//                
//            case RequestDataInitiateRequest:
//                [self InitiateRequest]; //
//                break;
//                
//            case RequestDataParticipate:
//                
//                break;
//                
//            default:
//                break;
//        }
//        
//    }else {
    
       //    }
    
   
    
    
}
#warning   --------- 我发起的活动的请求-
-(void)InitiateRequest {
    
  
    // 查询活动
    AVQuery *aQ = [SWActivityList query];
    
    aQ.limit = 20;
    [aQ addDescendingOrder:@"createdAt"]; // 排序
    
    [aQ whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
    [aQ includeKey:@"createBy"];
    
    [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        SWActivityList *acc = objects[16];
//        SWLog( @" acc %@",acc.titleImage.url);  // 测试 图片链接
        for (SWActivityList *a in objects) {
            
            [self.dataArray addObject:a];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
//                SWLog(@"-----------++++ ---- %@",self.dataArray);
            
            [self.ztableView reloadData];
        });
    }];
    
    
}
#warning -=----=-=-=-=-=-=-我参与的活动的请求

-(void)jionInRequest {
    
    
    AVQuery *aqq = [SWComment query];
    
    aqq.limit = 20;
    [aqq addDescendingOrder:@"createdAt"];//排序
    
    [aqq whereKey:@"commentBy" equalTo:[SWLcAvUSer currentUser]];
    
    [aqq includeKey:@"forActivity"];
    [aqq includeKey:@"commentBy"];
    [aqq whereKeyDoesNotExist:@"forComment"];
    [aqq findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
          SWLog(@"++++++++++++++++++++++rfdegdeg er==== =  =x x %@",objects);
        for (SWComment *comment in objects) {
          
            [self.dataArray addObject:comment];
        }
          dispatch_async(dispatch_get_main_queue(), ^{
              [self.ztableView reloadData];
             
          });
        
    }];
    
    
}
#warning 我的收藏请求----------

-(void)makeRequest {
    
    // 查询活动
    AVQuery *aQ = [SWMark  query];
    
    aQ.limit = 20;
    //    [aQ whereKey:@"creatBy" equalTo:[AVUser currentUser]];
    [aQ addDescendingOrder:@"createdAt"]; // 排序
    //    SWLog(@"22222222222222222%@",self.rootVC.followArray);
    [aQ whereKey:@"markBy" equalTo:[SWLcAvUSer currentUser]];
//    [aQ includeKey:@"markBy"];
    [aQ includeKey:@"activity"];
    
    [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (SWMark *a in objects) {
            
            [self.dataArray addObject:a.activity];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //                SWLog(@"-----------++++ ---- %@",self.dataArray);
            
            [self.ztableView reloadData];
        });
        
    }];
}
     


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    NSLog(@"2312312312%lu",self.RequestData);
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
    
   

    /**
     *  OOOO
     */
    switch (self.RequestData) {
        case RequestDataFoucesRequest:
            [self performSelector:@selector(requestData) withObject:nil afterDelay:0.5];
            break;
            
        case RequestDataInitiateRequest:
            [self InitiateRequest];
            break;
            
        case RequestDataParticipate:
            [self jionInRequest];
            break;
        case  RequestDataMark:
            
            [self   makeRequest];
            
            break;
            
        default:
            break;
    }
 
    
    
    
    
}
#warning 请求数据
-(void)requestData {
    
    // 查询活动
    AVQuery *aQ = [SWActivityList query];
   
    aQ.limit = 20;
    //    [aQ whereKey:@"creatBy" equalTo:[AVUser currentUser]];
    [aQ addDescendingOrder:@"createdAt"]; // 排序
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
- (void)onClick:(SWFridenSharOnTableViewCell *)cell {
    
    
    SWUserDetailViewController *usrVC = [[SWUserDetailViewController alloc]init];
    NSIndexPath *indexPath =  [self.ztableView indexPathForCell:cell];
    
           SWActivityList *act  =  self.dataArray[indexPath.row];
    
           usrVC.userString = act.createBy.objectId;
    
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
    
    switch (self.RequestData) {
   
        case RequestDataParticipate:
        {
            SWJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.joinDelegate = self;
            
            SWComment *comment = self.dataArray[indexPath.row];
            cell.comment = comment;
            
            
           // cell.detailImage.hidden = YES;
            return cell;

        }
            break;
            
        default:

        {
            SWFridenSharOnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FridenSharOnCell"];
            cell.friendDelegate = self;
            
            SWActivityList *list = self.dataArray[indexPath.row];
            /**
             *  //////////////////////
             */
            if (list.createBy.displayName) {
                cell.FriendName.text =list.createBy.displayName;
                
            }else {
                cell.FriendName.text =list.createBy.username;
                
                NSLog(@"3434454565667788990876543    BGVC HNYDSXJUKHJYCV JKL,V L  %@",list.createBy.username);
            }
            cell.title.text = list.title;
            [cell.detailImv setImageWithURL:[NSURL URLWithString:list.titleImage.url]];
            cell.collectNum.text = [NSString stringWithFormat:@"收藏 %@",list.markC];
            
            
            AVQuery *avQ = [SWComment query];
            [avQ whereKey:@"forActivity" equalTo:list];
            [avQ countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
                cell.joinNum.text = [NSString stringWithFormat:@"参与 %ld",number];
            }];
            
            cell.BJLable.text =  list.label;
            cell.GZlABLE.text = list.rule;
            AVFile *ff = [AVFile fileWithURL:list.createBy.userImage.url];
            [ff getThumbnail:YES width:200 height:200 withBlock:^(UIImage *image, NSError *error) {
                [cell.Friendicon  setImage:image forState:(UIControlStateNormal)];
                
                self.ztableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                //        AVQuery *avq =  [AVQuery queryWithClassName:@"_User"];
                //
                //        [avq whereKey:@"objectId" equalTo:self.userString];
                
            }];
            return cell;
            
        }

            break;
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 280;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([SWFridenSharOnTableViewCell class] == [[self tableView:_ztableView cellForRowAtIndexPath:indexPath] class]) {
        
        SWFridenSharOnTableViewCell *cell = (SWFridenSharOnTableViewCell *)[self tableView:_ztableView cellForRowAtIndexPath:indexPath];
        SWshowViewController *showVC = [[SWshowViewController alloc]init];
        
        
           SWActivityList *list = self.dataArray[indexPath.row];
        
        
        showVC.joinStr = [NSString stringWithFormat:@"收藏 %@",list.markC];
        
        
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
        
    }else {
        
       #warning-----------------------------
        
        SWJoinTableViewCell *cell = (SWJoinTableViewCell *)[self tableView:_ztableView cellForRowAtIndexPath:indexPath];
        SWshowViewController *showVC = [[SWshowViewController alloc]init];
       
        SWComment *comment = self.dataArray[indexPath.row];
        showVC.activity =  comment.forActivity;
        
        
        AVQuery *Q = [SWLcAvUSer query];
        
        [Q whereKey:@"objectId" equalTo:showVC.activity.createBy.objectId];
        [Q includeKey:@"userImage"];
        [Q selectKeys:@[@"displayName", @"username", @"userImage"]];
        
        [Q findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            SWLcAvUSer *user  = objects[0];
            
            if (user.displayName) {
                showVC.string = user.displayName;
            }else {
                showVC.string = user.username;
            }
            showVC.titlestring = user.userImage.url;
            
            
            SWLog(@" --- ---- --- %@", showVC.string);
            SWLog(@" --- ---- --- %@", showVC.titlestring);
            
        }];
        
        
        
        
        showVC.dataImage = cell.detailImage.image;

        
        [self.navigationController  pushViewController:showVC animated:YES];
        self.rootVC.swTabBar.hidden = YES;
        
        
        
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
