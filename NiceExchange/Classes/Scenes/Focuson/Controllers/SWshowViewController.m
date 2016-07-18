//
//  SWshowViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWshowViewController.h"
#import "SWcommentViewController.h"

#import "UMSocialSnsService.h"
#import "UMSocialData.h"
#import "UMSocialSnsPlatformManager.h"

@interface SWshowViewController ()<UMSocialUIDelegate>

@property (nonatomic,assign) NSInteger touch;

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic,strong)NSTimer *time;

@end

@implementation SWshowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.touch = 0;
    //左上方返回按钮
    [self backButtonItem];
    self.title = @"参与沙龙";
    //右上方添加分享按钮
    [self addRightButtonItem];
    //添加底部视图
    [self addtopicviews];
    self.view.backgroundColor = [UIColor whiteColor];
    //头像切圆角
    self.icon.layer.cornerRadius = self.icon.frame.size.width / 2;
    self.icon.layer.borderWidth = 1.0;
    self.icon.layer.borderColor =[UIColor clearColor].CGColor;
    self.icon.clipsToBounds = TRUE;//去除边界
    
}

-(void)addtopicviews {
    
    UIButton *view = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
    [view addTarget:self action:@selector(commentAction:) forControlEvents:(UIControlEventTouchUpInside)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    UIImageView *imageVC = [[UIImageView alloc]initWithFrame:CGRectMake(5, view.frame.origin.y + 5, 40, 40)];
    imageVC.layer.cornerRadius = imageVC.frame.size.width /2;
    imageVC.layer.masksToBounds = YES;
    imageVC.image = [UIImage imageNamed:@"我要参加.png"];
    
    [self.view addSubview:imageVC];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageVC.frame) + 30, imageVC.frame.origin.y, 80, 40)];
    
    lable.text = @"参与沙龙";
    lable.font = [UIFont systemFontOfSize:17];
    lable.textColor = [UIColor colorWithRed:50/256.0 green:50/256.0 blue:50/256.0 alpha:.5];
    [self.view addSubview:lable];
    
    self.btn = [UIButton buttonWithType:0];
    self.btn.frame = CGRectMake(CGRectGetMaxX(view.frame) - 49, view.frame.origin.y +4.5
                                , 40, 40);
    
    [  self.btn addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [  self.btn setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:(UIControlStateNormal)];
    [self.view addSubview:  self.btn];
    
}
//跳转到评论界面
-(void)commentAction:(UIButton *)sender {
    
    SWcommentViewController *commentVC = [[SWcommentViewController alloc]init];
    
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

//收藏按钮
-(void)collectionAction:(UIButton *)sender {
    
    
    
    if (self.touch == 1) {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:(UIControlStateNormal)];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 200, 10000, 400, 40)];
        lable.backgroundColor = [UIColor blackColor];
        lable.alpha = .5;
        lable.textColor = [UIColor whiteColor];
        lable.text = @"已取消收藏";
        lable.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:lable];
        lable.tag = 333;
        lable.textAlignment = NSTextAlignmentCenter;
        [UIView animateWithDuration:.2 animations:^{
            lable.frame = CGRectMake(self.view.frame.size.width / 2 - 60, self.view.frame.size.height - 120, 120, 40);
            
        }];
        
        UILabel *lableV  = [self.view viewWithTag:123];
        [lableV removeFromSuperview];
        
        self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(disapperAction) userInfo:nil repeats:NO];
        
        self.touch = 0;
    }else if (self.touch == 0) {
        
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 200, 10000, 400, 40)];
        lable.tag = 123;
        lable.backgroundColor = [UIColor blackColor];
        lable.alpha = .5;
        lable.textColor = [UIColor whiteColor];
        lable.text = @"收藏成功,你会在首页看到此沙龙的动态";
        lable.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:lable];
        lable.textAlignment = NSTextAlignmentCenter;
        [UIView animateWithDuration:.2 animations:^{
            lable.frame = CGRectMake(self.view.frame.size.width / 2 - 150, self.view.frame.size.height - 120, 300, 40);
        }];
        
        [  self.btn setBackgroundImage:[UIImage imageNamed:@"已收藏.png"] forState:(UIControlStateNormal)];
        
        UILabel *lableV  = [self.view viewWithTag:333];
        [lableV removeFromSuperview];
        self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(disapperAction) userInfo:nil repeats:NO];
        self.touch = 1;
    }
    
}
//计时器方法
-(void)disapperAction {
    
    UILabel *lableV  = [self.view viewWithTag:123];
    [lableV removeFromSuperview];
    
    UILabel *lable  = [self.view viewWithTag:333];
    [lable removeFromSuperview];
    
}


-(void)backButtonItem {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector
                                             (backAction:)];
    
}

-(void)backAction:(UIBarButtonItem *)back {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    //返回显示tabbar
    self.rootVC.swTabBar.hidden = NO;
}
//右上方添加好友按钮
-(void)addRightButtonItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction:)];
}
//ButtonItem点击方法
-(void)shareAction:(UIBarButtonItem *)shared {
    
#warning 友盟分享、、
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://7xavwz.com2.z0.glb.qiniucdn.com/5093b0ee586aef4d2ebd421daadb764a_960_1280_.jpg?imageView2/2/w/550"];
    
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"关于我从刺绣小白到开了一家刺绣饰品店你有想了解的吗，http://www.salonwith.com/?salonid=23316"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
    
    

    
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
