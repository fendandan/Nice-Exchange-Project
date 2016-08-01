//
//  MusicDetailViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "BaseOrganViewController.h"
#import "MusicPlayerViewController.h"

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *MusicArray;

@property(nonatomic,strong)UIImageView *imageV;


@end

@implementation MusicDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableView];
    
    
   [self MusicRequest];
}


//添加 tableView
- (void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    
    //添加头视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 550)];
    
    self.imageV = [[UIImageView alloc] initWithFrame:view.frame];
    [view addSubview:self.imageV];
    self.tableView.tableHeaderView = view;
    
    
    //注册
    [self.tableView  registerNib:[UINib nibWithNibName:@"MusicDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MusicDetailTableViewCell_Identifiter];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}






//数据请求
- (void)MusicRequest
{
    self.MusicArray = [NSMutableArray array];
    
    MusicRequest *request = [MusicRequest new];
    
    [request musicDetailRequestparameter:@{@"urlString":self.urlString} success:^(NSDictionary *dic) {
        
        NSDictionary *dataDic = dic[@"data"];
        
    
        NSMutableArray *songsArr = dataDic[@"songs"];
        
        
        for (NSDictionary *dic in songsArr) {
            

            
            
            [self.MusicArray addObject:dic];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MusicArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MusicDetailTableViewCell_Identifiter forIndexPath:indexPath];
    
    NSDictionary *dic = self.MusicArray[indexPath.row];
    
    cell.titleLabel.text = dic[@"song_name"];
    
    cell.authorLabel.text = dic[@"singers"];
    
    NSString *string = self.detailImage;

    NSRange range = [string rangeOfString:@"@"];
    
    NSString *str = [string substringToIndex:range.location];
    
    [self.imageV setImageWithURL:[NSURL URLWithString:str]];
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



//cell 跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayerViewController *musicVC = [MusicPlayerViewController new];
    

    [self.navigationController pushViewController:musicVC animated:YES];
    
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
