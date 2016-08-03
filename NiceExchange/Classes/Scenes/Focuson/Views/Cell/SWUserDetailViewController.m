//
//  SWUserDetailViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/16.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWUserDetailViewController.h"
#import "SWusrTableViewCell.h"
#import "SWpratTableViewCell.h"
#import "SWcollectionTableViewCell.h"
@class SWUserDetailViewController;
@class SWcollectionTableViewCell;
@interface SWUserDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *focusTableview;
@property (nonatomic ,strong)NSString  *collectionString;
@property (nonatomic,strong) NSString *activityString;
@property (nonatomic, strong)NSString *commentCString;
@end

@implementation SWUserDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    self.rootVC.swTabBar.hidden = NO;


}

- (void)requestData {
{
    
    AVQuery *avq =  [AVQuery queryWithClassName:@"_User"];
    
    [avq whereKey:@"objectId" equalTo:self.userString];
    
    [avq includeKey:@"count"];
    
    [avq findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       
        SWLcAvUSer *user = objects[0];
        
        self.nameL.text = user.username;
        [self.iconI  setImageWithURL:[NSURL URLWithString:user.userImage.url]];
     
    
        _collectionString = user.count.markC.stringValue;
              NSLog(@"-----%@", _collectionString);
  
         //发起
        _activityString = user.count.activityC.stringValue;
        //参与
        _commentCString =     user.count.commentC.stringValue;
        //关注
        self.focusL.text =         user.count.followC.stringValue;
        //被关注
        self.befocus.text =       user.count.followedC.stringValue;
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@",user);
 
        
        [self.focusTableview reloadData];
        
    }];
    
    
    
}
    
    
    
    
    
}







- (void)viewDidLoad {
    [super viewDidLoad];
        [self requestData];
self.title = @"个人资料";
    self.headerView.layer.masksToBounds = YES;
    self.headerView.layer.cornerRadius = 20;
    self.headerView.layer.borderWidth = 10.0;
    self.headerView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.focusTableview.layer.masksToBounds = YES;
    self.focusTableview.layer.cornerRadius = 20;
    self.focusTableview.layer.borderWidth = 10.0;
    self.focusTableview.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.focusTableview registerNib:[UINib nibWithNibName:@"SWusrTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWusrTableViewCell"];
    
     [self.focusTableview registerNib:[UINib nibWithNibName:@"SWpratTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWpratTableViewCell"];
    
    [self.focusTableview registerNib:[UINib nibWithNibName:@"SWcollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SWcollectionTableViewCell"];
    
    self.focusTableview.delegate = self;
    self.focusTableview.dataSource = self;
    [self addviews];
    
}

-(void)addviews {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发私信" style:(UIBarButtonItemStylePlain) target:self action:@selector(messageAction:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(popAction:)];
}

-(void)popAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    self.rootVC.swTabBar.hidden = YES;
}

-(void)messageAction:(UIBarButtonItem *)sender {
    
    NSLog(@"发私信");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
          SWusrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWusrTableViewCell"];
    
    cell.initiateL.text = _activityString;
    
    return cell;
        
    }else if (indexPath.row == 1){
        SWpratTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWpratTableViewCell"];
        
        cell.participateL.text = _commentCString;
        return cell;
        
    }
        SWcollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWcollectionTableViewCell"];
        
        cell.collectionCount.text = _collectionString;
    
    
    return cell;
 
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}



//关注方法
- (IBAction)focusBtn:(UIButton *)sender {
}
//拉黑方法
- (IBAction)shieldingBtn:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
    return 80;
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
