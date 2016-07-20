//
//  RedaViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "RedaViewController.h"
#import "ReadTableViewCell.h"


@interface RedaViewController ()
<
   UITableViewDataSource,
   UITableViewDelegate,
   ReadTableViewCellDelegate
>

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation RedaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    [self requestData];
    [self addTableView];
    
    
    self.tableView.delegate = self;
    
    
    
    
    
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
    
    
    SWActivityList *activity = self.dataArray[indexPath.row];
    
    cell.titleLabel.text = activity.title;
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


- (void)requestData {
    // 查询活动
    AVQuery *aQ = [SWActivityList query];
    //    [aQ whereKey:@"creatBy" equalTo:[AVUser currentUser]];
    [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (SWActivityList *a in objects) {
            SWActivityList *ac = a;
            [self.dataArray addObject:ac];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}





- (void)readTableViewPlayBtnClickend:(ReadTableViewCell *)cell
{
    
    
    if (cell.attentionBtn.selected == YES) {
        
        UIAlertController *uialert = [UIAlertController alertControllerWithTitle: nil message:@"不再关注此用户" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            cell.attentionBtn.selected = NO;
            
        }];
        
        [uialert addAction:action1];
        [uialert addAction:action2];
        
        [self presentViewController:uialert animated:YES completion:nil];
        
        
    }else{
        cell.attentionBtn.selected = YES;
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
