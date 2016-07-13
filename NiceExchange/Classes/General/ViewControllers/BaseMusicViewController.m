//
//  BaseShowViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseMusicViewController.h"

@interface BaseMusicViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;



@end

@implementation BaseMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self addScrollView];//添加滚动视图
    
   
    
    
    
    
    
}


//添加 scrollView
- (void)addScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 7, 0);
    
    self.scrollView.pagingEnabled = YES;
    
    
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
