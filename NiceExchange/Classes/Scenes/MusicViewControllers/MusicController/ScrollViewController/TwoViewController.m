//
//  TwoViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
<
  UITableViewDataSource,
  UITableViewDelegate
>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self addTableView];
    
    
    [self twoMusicRequest];
}




//请求数据
- (void)twoMusicRequest
{
    MusicRequest *request = [MusicRequest new];
    
   
    [request threeScrollRequestparameter:nil success:^(NSDictionary *dic) {
        
        [self.imageV setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"pic_300"]]];
        
        self.dataArray = dic[@"content"];
        
        NSLog(@"%@",self.dataArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}





- (void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    
    [self.view addSubview:self.tableView];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 550)];
    
    view.backgroundColor = [UIColor yellowColor];
    
    self.imageV = [[UIImageView alloc] initWithFrame:view.frame];
    
    [view addSubview:self.imageV];
    
    self.tableView.tableHeaderView = view;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    
    
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
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
