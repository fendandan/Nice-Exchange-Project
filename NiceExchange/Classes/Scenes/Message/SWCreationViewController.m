//
//  SWCreationViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWCreationViewController.h"
#import "SWAddRule.h"
#import "SWMessViewController.h"

@interface SWCreationViewController ()
<
UITextFieldDelegate,
UITextViewDelegate
>
@property(nonatomic,strong)UIImageView *imageview;//箭头
@property (nonatomic,strong)UITextField *titleTF;//标题
@property (nonatomic,strong)UITextView *textview;//
@property (nonatomic, strong)SWAddRule *addrule;
@end

@implementation SWCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self releaseAction];
}
-(void)releaseAction
{
    self.navigationItem.title = @"发布";
    //navgation 点击事件
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(itemRightAction:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"存草稿" style:UIBarButtonItemStyleDone target:self action:@selector(itemRightsAction:)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
    //
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:scroll];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpeg"]];
    image.backgroundColor = [UIColor grayColor];
    [scroll addSubview:image];
    //上传图片
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 150, 100, 20, 20)];
    self.imageview.layer.masksToBounds = YES;
    self.imageview.layer.cornerRadius = self.imageview.bounds.size.width/2;
    self.imageview.image = [UIImage imageNamed:@"2.png"];
    self.imageview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageview];
    UIButton *uploadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadbtn.frame = CGRectMake(self.view.bounds.size.width -130 , 100, 130, 20);
    // uploadbtn.backgroundColor = [UIColor orangeColor];
    [uploadbtn setTitle:@"上传封面图片"forState:UIControlStateNormal];
    [uploadbtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:uploadbtn];
    //添加标签
    UIButton *addlabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addlabBtn.frame = CGRectMake(150,180 , 120, 30);
    addlabBtn.layer.masksToBounds = YES;
    addlabBtn.layer.cornerRadius = addlabBtn.bounds.size.height/4;
    [addlabBtn setTitle:@"➕添加标签" forState:UIControlStateNormal];
    [addlabBtn setBackgroundColor:[UIColor blackColor]];
    [addlabBtn addTarget:self action:@selector(addlabBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [scroll addSubview:addlabBtn];
    //活动标题
    self.titleTF.delegate = self;
    self.titleTF = [[UITextField alloc]initWithFrame:CGRectMake(20 , 220,self.view.bounds.size.width -40, 60)];
    self.titleTF.backgroundColor = [UIColor cyanColor];
    self.titleTF.layer.masksToBounds = YES;
    self.titleTF.layer.cornerRadius = self.titleTF.bounds.size.height/4;
    [self.titleTF setFont:[UIFont fontWithName:@"" size:20]];
    self.titleTF.placeholder = @"来个响亮的名字";
    [scroll addSubview:self.titleTF];
    
    self.textview = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleTF.frame) , CGRectGetMaxY(self.titleTF.frame)+10,self.titleTF.frame.size.width, 60)];
    self.textview.layer.masksToBounds = YES;
    self.textview.layer.cornerRadius = self.textview.bounds.size.height/4;
    self.textview.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.textview];
    
    //self.textview.frame = CGRectMake(CGRectGetMinX(self.titleTF.frame), CGRectGetMaxY(self.titleTF.frame)+10, self.titleTF.frame.size.width, self.textview.contentSize.height);
    //添加规则
    self.addrule = [[SWAddRule alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textview.frame),CGRectGetMaxY(self.textview.frame) +10,self.textview.frame.size.width,160 )];
    self.addrule.backgroundColor = [UIColor whiteColor];
    self.addrule.layer.masksToBounds = YES;
    self.addrule.layer.cornerRadius = self.addrule.frame.size.height/5;
    [scroll addSubview:self.addrule];
}
//textFiled限制长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.titleTF) {
        if (self.titleTF.text.length > 20 )
            return NO;
    }
    return YES;
}
//textview 自适应高度


//navgation
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
    [self.navigationController pushViewController:[[SWMessViewController alloc] init] animated:YES];
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
