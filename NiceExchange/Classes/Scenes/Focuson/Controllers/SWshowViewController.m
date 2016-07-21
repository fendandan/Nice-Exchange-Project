//
//  SWshowViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWshowViewController.h"
#import "SWcommentViewController.h"
#import "SWUserDetailViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocialData.h"
#import "UMSocialSnsPlatformManager.h"
#import "XYSpriteHelper.h"
#import "BaseSwitchViewController.h"
#import "SWCommentsTableViewCell.h"
#define kFirstSegmentedIndex 0

#define kSecondSegmentedIndex 1

@interface SWshowViewController ()<UMSocialUIDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *collectionScrollView;

@property (strong, nonatomic) IBOutlet UIView *stView;

@property (nonatomic,assign) NSInteger touch;
@property (nonatomic,strong) UISegmentedControl *segmented;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong)UIView *collectionView;
@property (nonatomic,strong)NSTimer *time;
@property (nonatomic,strong)UILabel *lable;
@property (nonatomic,strong)UILabel *lable1;
@property (nonatomic,strong)BaseSwitchViewController *switchVC;
@end

@implementation SWshowViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[XYSpriteHelper sharedInstance]startTimer];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[XYSpriteHelper sharedInstance]stopTimer];
}

- (void)dealloc {
    
    [[XYSpriteHelper sharedInstance]clearAllSprites];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
      self.touch =0;
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
    [self.icon addTarget:self action:@selector(PushAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
  self.view.backgroundColor = [UIColor colorWithRed:78/256.0 green:78/256.0 blue:78/256.0 alpha:1.0];
    
  
    
    
    
    
    //**
    self.collectionScrollView.delegate = self;
    self.collectionView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 40, self.view.frame.size.height - 59)];
//    self.collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.userInteractionEnabled = YES;
    self.collectionScrollView.userInteractionEnabled = YES;
    self.collectionView.hidden = YES;

    
    /**
     *  /////////////////tableView
     */
   _switchVC = [[BaseSwitchViewController alloc]init];
    [self addChildViewController:_switchVC];
    [self.collectionView addSubview:_switchVC.view];
  
    _switchVC.scrollView.frame = self.collectionView.frame;
    _switchVC.leftTableView.frame = CGRectMake(10, 80, self.view.frame.size.width - 60, self.view.frame.size.height);
        _switchVC.rightTableView
    .frame = CGRectMake(_switchVC.leftTableView.frame.size.width +30, 80, _switchVC.scrollView.frame.size.width -20 , self.view.frame.size.height);
    _switchVC.scrollView.delegate = self;
    
 SWLog(@"%@",_switchVC.view);
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"收藏"]];
    
    imageview.frame = CGRectMake(0,0 , self.view.frame.size.width, 20) ;
    imageview.backgroundColor = [UIColor redColor];
    [_switchVC.scrollView  addSubview:imageview];
    _switchVC.scrollView.scrollEnabled = YES;
    _switchVC.leftTableView.delegate = self;
    _switchVC.leftTableView.dataSource = self;
    _switchVC.rightTableView.delegate = self;
    _switchVC.rightTableView.dataSource = self;
    _switchVC.leftTableView.backgroundColor = [UIColor whiteColor];
    [_switchVC.leftTableView registerNib:[UINib nibWithNibName:@"SWCommentsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"commentCell"];
// 
      [_switchVC.rightTableView registerNib:[UINib nibWithNibName:@"SWCommentsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RcommentCell"];
    
    _switchVC.scrollView.contentSize =  CGSizeMake(800 , 0);
    ////////////////////////////  XYSpriteView ////////////////////////////
    XYSpriteView *tmpSprite = [[XYSpriteView alloc] initWithFrame:CGRectMake(0, 80, 224, 138)];
    tmpSprite.firstImgIndex = 1;
    [tmpSprite formatImg:@"p31b%0.4d.png" count:180 repeatCount:0];
    [tmpSprite showImgWithIndex:0];
    tmpSprite.delegate = self;
    [[XYSpriteHelper sharedInstance].sprites setObject:tmpSprite forKey:@"a"];
    [self.view addSubview:tmpSprite];
    
    tmpSprite = [[XYSpriteView alloc] initWithFrame:CGRectMake(0, 40, 320, 480)];
    [tmpSprite formatImg:@"p3_b_%d.png" count:24 repeatCount:0];
    [tmpSprite showImgWithIndex:0];
    tmpSprite.delegate = self;
    [[XYSpriteHelper sharedInstance].sprites setObject:tmpSprite forKey:@"b"];
    [self.view addSubview:tmpSprite];
    
    [[XYSpriteHelper sharedInstance] startAllSprites];
    
    
    
    _segmented = [[UISegmentedControl alloc]initWithItems:@[@"最新评论",@"最热评论"]];
  
    _segmented.frame = CGRectMake(self.collectionView.frame.size.width /2 - 80, 57, 160, 40) ;
    [_segmented addTarget:self action:@selector(chageClick:) forControlEvents:(UIControlEventValueChanged)];
    [self.collectionView addSubview:_segmented];
    
}

-(void)chageClick:(UISegmentedControl *)sender {
    
    _switchVC.scrollView.contentOffset = CGPointMake(_segmented.selectedSegmentIndex * _switchVC.scrollView.frame.size.width, 0);
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _segmented.selectedSegmentIndex = _switchVC.scrollView.contentOffset.x / _switchVC.scrollView.frame.size.width;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    if ( tableView == _switchVC.rightTableView) {
      
        
        SWCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RcommentCell"];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
    }
    
    SWCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
     cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
  
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll---->%f",self.scrollView.contentOffset.y);
    if (self.collectionScrollView.contentOffset.y >= 650) {
        self.collectionView.hidden = NO;
    }else {
        
        self.collectionView.hidden = YES;
        self.rootVC.swTabBar.hidden = NO;
    }
    
}



-(void)PushAction:(UIButton *)sender {
    SWUserDetailViewController *usrVC = [[SWUserDetailViewController alloc]init];
    
    [self.navigationController pushViewController:usrVC animated:YES];
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
    self.scrollView .contentSize = CGSizeMake(0 ,self.view.frame.size.height * 7);
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 282;
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
