//
//  SWPublishViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWPublishViewController.h"

@interface SWPublishViewController ()

@property(nonatomic,strong)UIImageView *imageview;//箭头
@property (nonatomic,strong)UITextField *titleTF;//标题
@property (nonatomic,strong)UITextField *themeTF;//主题
@property (nonatomic, strong)SWAddRule *addrule;

@end

@implementation SWPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addmessage];
}
-(void)addmessage
{
    self.navigationItem.title = @"我的";
    //navgation 点击事件
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(itemRightAction:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"存草稿" style:UIBarButtonItemStyleDone target:self action:@selector(itemRightsAction:)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    //UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpeg"]];
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    image.backgroundColor = [UIColor grayColor];
    [self.view addSubview:image];
    //上传图片
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-100, 100, 20, 20)];
    //self.imageview.image = [UIImage imageNamed:@"2.png"];
    self.imageview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageview];
    UIButton *uploadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadbtn.frame = CGRectMake(self.view.bounds.size.width -80 , 100, 80, 20);
    uploadbtn.backgroundColor = [UIColor orangeColor];
    [uploadbtn setTitle:@"上传封面图片"forState:UIControlStateNormal];
    [uploadbtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadbtn];
    UIButton *addlabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addlabBtn.frame = CGRectMake(self.view.bounds.size.width - 240, self.view.bounds.size.height-590, 120, 30);
    addlabBtn.backgroundColor = [UIColor orangeColor];
    [addlabBtn setTitle:@"➕添加标签" forState:UIControlStateNormal];
    [addlabBtn addTarget:self action:@selector(addlabBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addlabBtn];
    self.titleTF = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 360 , self.view.bounds.size.height-550,300, 100)];
    self.titleTF.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.titleTF];
    self.themeTF = [[UITextField alloc]initWithFrame:CGRectMake(self.view.bounds.size.width -360 , self.view.bounds.size.height -430 , 300, 100)];
    self.themeTF.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.themeTF];
    
   self.addrule = [[SWAddRule alloc]initWithFrame:CGRectMake(self.view.bounds.size.width -360, self.view.bounds.size.height-300, 200, 100)];
    //self.addrule.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.addrule];
   
    
}
-(void)itemRightAction:(UIBarButtonItem *)sender{
    NSLog(@"嘿嘿");
    
}
-(void)itemRightsAction:(UIBarButtonItem *)sender{
    NSLog(@"嘿嘿");
}
//button
-(void)uploadAction:(UIButton *)sender{
    NSLog(@"上传图片");
    
}
-(void)addlabBtnAction:(UIButton *)sender{
    NSLog(@"添加标签");
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
