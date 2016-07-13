//
//  BaseShowViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseShowViewController.h"

@interface BaseShowViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIScrollView *leftScrollView;

@property (nonatomic, strong) UIScrollView *rightScrollView;

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation BaseShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addScrollView];
    
    self.scrollView.delegate = self;
    
    
}



//添加 scrollview
- (void)addScrollView
{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    
    //设置分页
    self.scrollView.pagingEnabled = YES;

    //设置边界
    self.scrollView.bounces = NO;
    
//    //缩放比例
//    self.scrollView.minimumZoomScale = 0.5;
//    self.scrollView.maximumZoomScale = 2.0;
  
    
    
   // 子视图1
    self.leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, self.scrollView.frame.size.height)];
    self.leftScrollView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:self.leftScrollView];

    self.leftScrollView.minimumZoomScale = 0.5;
    self.leftScrollView.maximumZoomScale = 2.0;
    
    
    //子视图2
    self.rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.frame.size.height)];
    
    self.rightScrollView.backgroundColor = [UIColor greenColor];
    
    [self.scrollView addSubview:self.rightScrollView];
    
    
    self.rightScrollView.minimumZoomScale = 0.5;
    self.rightScrollView.maximumZoomScale = 2.0;
    
//    NSLog(@"%f",self.rightScrollView.minimumZoomScale);
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.imageV.image = [UIImage imageNamed:@"1.png"];
    [self.rightScrollView addSubview:self.imageV];
    
}



//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    
//    
//    
//}







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
