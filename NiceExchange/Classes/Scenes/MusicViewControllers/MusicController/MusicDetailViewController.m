//
//  MusicDetailViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MusicDetailViewController.h"

@interface MusicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *MusicArray;

@end

@implementation MusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self addTableView];
}


//添加 tableView
- (void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    
    //注册
    [self.tableView  registerNib:[UINib nibWithNibName:@"MusicDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MusicDetailTableViewCell_Identifiter];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self MusicRequest];
    
    
}



//数据请求
- (void)MusicRequest
{
    self.MusicArray = [NSMutableArray array];
    
    MusicRequest *request = [MusicRequest new];
    
    [request musicRequestparameter:nil success:^(NSDictionary *dic) {
        
//        NSLog(@"DIC----%@",dic);
        
        
        NSMutableArray *contentArray = [dic objectForKey:@"content"];
        
//        NSLog(@"1111%@",contentArray);
        
        
        for (NSDictionary *Dic in contentArray) {
            
//            NSLog(@"DIC%@",Dic);
            MusicDetailModel *model = [MusicDetailModel new];
            
            [model setValuesForKeysWithDictionary:Dic];
            
            
            [self.MusicArray addObject:model];
        }
        
//        NSLog(@"self.MusicArray%@",self.MusicArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MusicDetailTableViewCell_Identifiter forIndexPath:indexPath];
    
    
    
    
    return cell;
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
