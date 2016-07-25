//
//  SWcommentsViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/25.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWcommentsViewController.h"
#import "SWChatTableViewCell.h"
#import "SWViewController.h"
@interface SWcommentsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *commentTableView;

@property (nonatomic,strong)NSString *data;



@end

@implementation SWcommentsViewController
- (IBAction)pushAction:(UIButton *)sender {
    SWViewController *swVC = [SWViewController new];
    [self.navigationController pushViewController:swVC animated:YES];
    
#warning Blokc传值 第三步:实现Block的内容(接收传递过来的内容)
    
    //通过__block __weak修饰变量,来解决Block的循环引用,ARC模式下使用__weak
    __weak typeof(self) weakSelf = self;
    swVC.SecondBlock = ^(NSString *string){
      
        [self.dataArray  addObject:string];
        SWLog(@"%ld",self.dataArray.count);
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.commentTableView reloadData];
        });
       
    };

   


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataArray = [NSMutableArray new];
    self.dataArray = [NSMutableArray new];
    [self.commentTableView registerNib:[UINib nibWithNibName:@"SWChatTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
//
self.commentTableView.rowHeight=UITableViewAutomaticDimension;//这句表示cell的高度自适应
//    self.commentTableView.estimatedRowHeight=85.0f;//这个高度写xib视图的最小高度，也即label只有一行时的xib视图高度
#warning ==
  
//    NSString *a = @"不错";
//        NSString *b = @"很好";
////        NSString *c = @"推荐";
////        NSString *d = @"赞赞赞";
//  
////    [self.dataArray addObject:b];
////    [self.dataArray addObject:c];
////    [self.dataArray addObject:d];
    
   // NSLog(@"%lu",(unsigned long)self.dataArray.count);
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
       SWLog(@"%ld",self.dataArray.count);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.message
    .text = self.dataArray[indexPath.row];
   

    return cell;
    
}

- (CGFloat)textHeightFormMode:(NSString *)labeltext {
    CGRect rect = [labeltext boundingRectWithSize:CGSizeMake(193, 8000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     SWChatTableViewCell *cell = (SWChatTableViewCell *)[self tableView:_commentTableView cellForRowAtIndexPath:indexPath];
    
    CGFloat height  = [self textHeightFormMode:cell.message.text] + cell.message.frame.origin.y ;
    
     return  height;
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
