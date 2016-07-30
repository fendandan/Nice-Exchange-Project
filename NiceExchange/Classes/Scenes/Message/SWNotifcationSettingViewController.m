//
//  SWNotifcationSettingViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWNotifcationSettingViewController.h"
#import "SWNotfcTableViewCell.h"
@interface SWNotifcationSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UISwitch *chooswitch;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic, strong) UIView *backview;
//建立一个可变字典,记录选择的内容.
@property (nonatomic, strong)NSMutableDictionary *selectedSourceDic;
@property (nonatomic,strong)NSMutableArray *mutableArray;
@end

@implementation SWNotifcationSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedSourceDic = [[NSMutableDictionary alloc]init];
   // NSArray *array = [NSArray arrayWithObjects:@"打开",@"关闭", nil];
//     NSArray *array2 = [NSArray arrayWithObjects:@"打开",@"关闭", nil];
//     NSArray *array3 = [NSArray arrayWithObjects:@"打开",@"关闭", nil];
    self.mutableArray = [NSMutableArray arrayWithObjects:@"应用更新提示",@"系统更新提示",@"是否允许推送消息", nil];
    self.title = @"通知设置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 64, self.view.bounds.size.width -100, 40)];
    //self.titlelabel.backgroundColor = [UIColor grayColor];
    self.titlelabel.text = @"接收所有通知";
    [self.view addSubview:self.titlelabel];
    self.chooswitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.titlelabel.frame.size.width +30, 70, 0, 0)];
    //设置默认为yes (开
    self.chooswitch.on = YES;
    [self.view addSubview:self.chooswitch];
    [self.chooswitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
  //设置tableview
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.frame.size.height-155) style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    
    [self.tableview registerClass:[SWNotfcTableViewCell class] forCellReuseIdentifier:SWNotfcTableViewCell_cell];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"gSWNotfcTableViewCell_cell"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    
}
-(void)switchAction:(UISwitch *)sender
{
   
    SWLog(@"你真的,改变了");
    if (self.chooswitch.on == YES ) {
        SWLog(@"开启");
        self.backview.hidden = YES;
       // [self.tableview reloadData];
    }else
    {
        self.backview = [[UIView alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height- 155)];
        _backview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: _backview];
        SWLog(@"关闭");
        
    }
    [self.tableview reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = NO;
    SWNotfcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWNotfcTableViewCell_cell forIndexPath:indexPath];
    cell.yesLabel.text = @"打开";
    cell.noLabel.text = @"关闭";
   //将序号作为每一行的标题.
//    cell.yesLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row +1];
//    cell.noLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row ];
    //在cell里面添加按钮的点击事件
    [cell.yesButton addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.noButton addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //将点击cell产生的灰色效果去掉,否则会影响整体美观.
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    /*根据key值indexPath获取字典中存储的答案,主要的功能就是防止滑动时候内容的掩盖问题*/
    
    
//    if (!resultDic) {
//        
//    }
//    [self.selectedSourceDic setObject:[self getMarkWithKey:indexPath marcoPath:@"notification"] forKey:indexPath];
    NSString *selectResult = [self getMarkWithKey:[NSString stringWithFormat:@"%ld--%ld", indexPath.section, indexPath.row] marcoPath:@"notification"];
    SWLog(@" +++++++ &&& ______ %@", selectResult);
    if (selectResult) {
        
         //如果这个答案存在,说明这个按钮被选择过
        if ([selectResult isEqualToString:@"YES"]) {
             //选择的是A按钮,A按钮颜色变成灰色
            cell.yesButton.selected = YES;
           cell.noButton.selected = NO;
        }else
        {
            //选择的是B按钮,B按钮颜色变成灰色
            cell.yesButton.selected = NO;
            cell.noButton.selected = YES;
        }
        
    }else {
        [self addSaveK8VWithDicName:@"notification" Key:[NSString stringWithFormat:@"%ld--%ld", indexPath.section, indexPath.row] Value:@"YES"];
        [self.selectedSourceDic setObject:@"YES" forKey:[NSString stringWithFormat:@"%ld--%ld", indexPath.section, indexPath.row]];
        //设置按钮的图片样式,也可以改变颜色.
        cell.yesButton.selected = YES;
        cell.noButton.selected = NO;
    }
    return cell;
}

-(void)onBtnClick:(UIButton *)sender
{
    SWNotfcTableViewCell *cell = (SWNotfcTableViewCell *)sender.superview.superview;
    NSIndexPath *indextPath = [self.tableview indexPathForCell:cell];
//     NSString *lastSelectResult = [self.selectedSourceDic objectForKey:indextPath];
//    //如果lastSelectResult的值存在,说明这个cell上以及有按钮被选过了
//    if ([lastSelectResult isEqualToString:@"A"]) {
//        //改变原有选过的按钮颜色变成初始色
////        UIButton *lastSelectBtnA = [cell viewWithTag:1];
////        [lastSelectBtnA setImage:[UIImage imageNamed:@"practise_a_n_day"] forState:UIControlStateNormal];
//        sender = [cell viewWithTag:1];
//        sender.selected = YES;
//    } else {
//        //改变原有选过的按钮颜色变成初始色
////        UIButton *lastSelectBtnB = [cell viewWithTag:2];
////        [lastSelectBtnB setImage:[UIImage imageNamed:@"practise_b_n_day"] forState:UIControlStateNormal];
//        sender = [cell viewWithTag:2];
//        sender.selected = NO;
//    }
//    //并且需要移除这个曾经存在过的元素
//    [self.selectedSourceDic removeObjectForKey:indextPath];
//    
//    /*******************这个部分就是为了添加刚刚选中的按钮答案,以及修改他得背景颜色***************/
//    
//    
//    //这个就是添加新选中的按钮答案到字典,根据indexPath作为key,并改变选中时的背景图片
//    if (sender.tag == 1) {
////        [self.selectedSourceDic setObject:@"A" forKey:indextPath];
////        [sender setImage:[UIImage imageNamed:@"practise_a_s_day"] forState:UIControlStateNormal];
//        sender.selected = NO;
//    } else {
////        [self.selectedSourceDic setObject:@"B" forKey:indextPath];
////        [sender setImage:[UIImage imageNamed:@"practise_b_s_day"] forState:UIControlStateNormal];
//        sender.selected = YES;
//    }
//    NSLog(@"%@",self.selectedSourceDic);
    
    
    
    if (cell.yesButton.selected == YES && cell.noButton.selected == NO) {
        cell.yesButton.selected = NO;
        cell.noButton.selected = YES;
        
        [self.selectedSourceDic setObject:@"NO" forKey:[NSString stringWithFormat:@"%ld--%ld", indextPath.section, indextPath.row]];
        
        // 写入本地
        [self goToSaveK8VWithDicName:@"notification" Dic:self.selectedSourceDic];
        SWLog(@"---- ----- %@",self.documentPath);
        SWLog(@"---- ----- %@",self.selectedSourceDic);
       
    }else {
        cell.yesButton.selected = YES;
        cell.noButton.selected = NO;
        [self.selectedSourceDic setObject:@"YES" forKey:[NSString stringWithFormat:@"%ld--%ld", indextPath.section, indextPath.row]];
        
        // 写入本地
        [self goToSaveK8VWithDicName:@"notification" Dic:self.selectedSourceDic];
        SWLog(@"---- ----- %@",self.documentPath);
        SWLog(@"---- ----- %@",self.selectedSourceDic);
        
        
    }
    
    
    
}







-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //这里行高被我设定为固定值,如果需要动态设置推荐一个第三方库:UITableView+FDTemplateLayoutCell,
    return 80;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.mutableArray[section];
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
