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
#import "SWcommentsViewController.h"
#import "SWBaiduAPIViewController.h"
#define kFirstSegmentedIndex 0

#define kSecondSegmentedIndex 1

@interface SWshowViewController ()<UMSocialUIDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CommentDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *collectionScrollView;

@property (strong, nonatomic) IBOutlet UIView *stView;
@property (nonatomic, strong) UIButton *joinBtn;
@property (nonatomic,assign) NSInteger touch;
@property (nonatomic,strong) UISegmentedControl *segmented;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong)UIView *collectionView;
@property (nonatomic,strong)NSTimer *time;
@property (nonatomic,strong)UILabel *lable;
@property (nonatomic,strong)UILabel *lable1;
@property (nonatomic,strong)BaseSwitchViewController *switchVC;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *leftArray;
@end

@implementation SWshowViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   [[XYSpriteHelper sharedInstance]startTimer];
    [self valueOf];
}

- (void)setActivity:(SWActivityList *)activity {
    if (_activity != activity) {
        _activity = nil;
        _activity = activity;
        
       }
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
    self.switchVC.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.switchVC.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.dataArray = [NSMutableArray array];
    self.leftArray = [NSMutableArray array];
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
    
    imageview.frame = CGRectMake(0,0 , self.view.frame.size.width, 20);
    imageview.backgroundColor = [UIColor redColor];
    [_switchVC.scrollView  addSubview:imageview];
    _switchVC.scrollView.scrollEnabled = YES;
    _switchVC.leftTableView.delegate = self;
    _switchVC.leftTableView.dataSource = self;
    _switchVC.rightTableView.delegate = self;
    _switchVC.rightTableView.dataSource = self;
    _switchVC.leftTableView.backgroundColor = [UIColor whiteColor];
    _switchVC.rightTableView.backgroundColor = [UIColor whiteColor];
    [_switchVC.leftTableView registerNib:[UINib nibWithNibName:@"SWCommentsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"commentCell"];
//// 
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
#warning --- 评论数据
      [self requestcommentdata];

    
    
}

 -(void) valueOf {
  
    //[self add];
    
    self.userName.text = self.string;
    AVFile *ff = [AVFile fileWithURL:self.titlestring];
    [ff getThumbnail:YES width:200 height:200 withBlock:^(UIImage *image, NSError *error) {
        [self.icon  setImage:image forState:(UIControlStateNormal)];
    }];
    
    self.contL.text = self.activity.content;
    self.titleL.text = self.activity.title;
    self.biaoQL.text = self.activity.label;
    self.detail.text = self.activity.subhead;
    self.xzLable.text = self.activity.rule;
    self.imagedddddd.image = self.dataImage;
    self.collectionL.text = [NSString stringWithFormat:@"收藏%@",self.activity.markC];
   self.JOINl.text  = self.joinStr;
}


-(void)chageClick:(UISegmentedControl *)sender {
    
    _switchVC.scrollView.contentOffset = CGPointMake(_segmented.selectedSegmentIndex * _switchVC.scrollView.frame.size.width , 0);
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _segmented.selectedSegmentIndex = _switchVC.scrollView.contentOffset.x / _switchVC.scrollView.frame.size.width;
}

- (void)onAction:(UITableViewCell *)cell {

    SWcommentsViewController *commentVC = [SWcommentsViewController new];
    SWLog(@"99999999999 %@", [[cell superview] superview]);
    
    
    
    if (_switchVC.leftTableView == [[cell superview] superview]) {
        
#warning 11111111111111111111111111111111111
        NSIndexPath *indexPath = [_switchVC.leftTableView indexPathForCell:cell];
        
        SWComment *comment = self.leftArray[indexPath.row];
        
        commentVC.swcomment = comment;
       
        
    }else  {
        
        NSIndexPath *indexPath = [_switchVC.rightTableView indexPathForCell:cell];
        
        SWComment *comment = self.dataArray[indexPath.row];
        
        commentVC.swcomment = comment;
        
        
    }
    
    
    [self.navigationController pushViewController:commentVC animated:YES];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    if (self.collectionScrollView.contentOffset.y >= 650) {
        self.collectionView.hidden = NO;
#warning 2424
        self.rootVC.swTabBar.hidden  = YES;
        
        self.contL.hidden = YES;
        
    }else {
        
        self.collectionView.hidden = YES;
        self.rootVC.swTabBar.hidden = YES;
          self.contL.hidden = NO;
    }
    
}



-(void)PushAction:(UIButton *)sender {
    SWUserDetailViewController *usrVC = [[SWUserDetailViewController alloc]init];

    usrVC.userString = self.activity.createBy.objectId;
    
    
    [self.navigationController pushViewController:usrVC animated:YES];
}

-(void)addtopicviews {
    
    self.joinBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49)];
    [ self.joinBtn addTarget:self action:@selector(commentAction:) forControlEvents:(UIControlEventTouchUpInside)];
     self.joinBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: self.joinBtn];
     self.joinBtn.userInteractionEnabled = YES;
    UIImageView *imageVC = [[UIImageView alloc]initWithFrame:CGRectMake(5,  self.joinBtn.frame.origin.y + 5, 40, 40)];
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
    self.btn.frame = CGRectMake(CGRectGetMaxX( self.joinBtn.frame) - 49,  self.joinBtn.frame.origin.y +4.5
                                , 40, 40);
    
    [self.btn addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:(UIControlStateNormal)];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"已收藏.png"] forState:(UIControlStateSelected)];
    
    AVQuery *avQ = [SWMark query];
    [avQ whereKey:@"activity" equalTo:self.activity];
    [avQ countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (number == 1) {
            self.btn.selected = YES;
        }else if (number > 1) {
            SWLog(@"收藏功能出错，重复收藏了！");
        }
    }];
    

    
    [self.view addSubview:  self.btn];
    //[self.view bringSubviewToFront:self.btn];

}
//跳转到评论界面
-(void)commentAction:(UIButton *)sender {
    
    SWcommentViewController *commentVC = [[SWcommentViewController alloc]init];
    commentVC.swActivityList = self.activity;
    commentVC.detail = self.titleL.text;
    commentVC.detailll = self.detail.text;
    commentVC.aaa = self.contL.text;
    commentVC.bqL = self.biaoQL.text;
#warning -==-=-=---==--=-=-=-=-==-=-=-=-=-=-=-=-==-
    
#warning Blokc传值 第三步:实现Block的内容(接收传递过来的内容)
    
    //通过__block __weak修饰变量,来解决Block的循环引用,ARC模式下使用__weak
    __weak typeof(self) weakSelf = self;
    commentVC.SecondBlock = ^(SWComment *string){
#warning -----------------------------
        [self.dataArray  addObject:string];
        [self.leftArray insertObject:string atIndex:0];
        SWLog(@"11111%@",string);
        SWLog(@"%2222222ld",self.dataArray.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_switchVC.leftTableView reloadData];
            [_switchVC.rightTableView reloadData];
            
        });
    };
    [self.navigationController pushViewController:commentVC animated:YES];
    
}


-(void)requestcommentdata {
    
    
    [LCManager lcSelectCommentWithActivityList:self.activity conditions:@"createdAt" completion:^(NSArray *mArray) {
        
        [self.leftArray addObjectsFromArray:mArray ];
        NSLog(@"13++++++++++++++++89-%@",self.leftArray);
        [_switchVC.leftTableView reloadData];
    }];
    
    [LCManager lcSelectCommentWithActivityList:self.activity conditions:@"commentCount" completion:^(NSArray *mArray) {
        
        [self.dataArray addObjectsFromArray:mArray ];
        NSLog(@"1-------------------89-%@",self.dataArray);
        [_switchVC.rightTableView reloadData];
    }];
    
}





//收藏按钮
-(void)collectionAction:(UIButton *)sender {
    
    if (sender.selected == YES) {
       
            [LCManager lcToCancelMarkActivityWithActivityList:self.activity completion:^(NSArray *mArray) {
    
                LCManager.shareManagerBm = NO;
     
                
            }];

          [self animalCancle];
          sender.selected = NO;
    }else if ( sender.selected == NO) {
    
            [LCManager lcToMarkActivityWithActivityList:self.activity  completion:^(NSArray *mArray) {
    
                LCManager.shareManagerBm = NO;
                
            }];

        
        
        [self animalAdd];
        sender.selected = YES;
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
    
   UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"分享"] style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAction:)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"地图"] style:(UIBarButtonItemStylePlain) target:self action:@selector(pushMap:)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item];
}
//ButtonItem点击方法

-(void)pushMap:(UIBarButtonItem *)sender {
    
    SWBaiduAPIViewController *baiduMap = [SWBaiduAPIViewController new];
    baiduMap.longitude = self.activity.point.longitude;
    baiduMap.latitude = self.activity.point.latitude;
    //baiduMap.na.title = self.activity.title;
    baiduMap.string = self.activity.subhead;
    SWLog(@"++++++%@",baiduMap.string);
    [self.navigationController pushViewController:baiduMap animated:YES];
    
    
}
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _switchVC.leftTableView) {
        return   self.leftArray.count;
    }
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if ( tableView == _switchVC.rightTableView) {
        
        //        NSString *CellIdentifier = [NSString stringWithFormat:@"RcommentCell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
        //        SWCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
        //
        //        if (cell == nil) {
        //            cell = [[SWCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        SWCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RcommentCell"];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.commentDelegate = self;
        SWComment *comment = self.dataArray[indexPath.row];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    #warning RightTavleView---------
        cell.comment  = comment;
        
        return cell;
        //查询一级评论
        // LCManager lcSelectCommentWithActivityList:<#(SWActivityList *)#> completion:<#^(NSArray *mArray)completion#>
        
        
    }else {
    
    
    
    //
    //    NSString *CellIdentifier = [NSString stringWithFormat:@"commentCell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    //    SWCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
    //    if (cell == nil) {
    //        cell = [[SWCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    SWCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.commentDelegate = self;
    SWComment *comment = self.leftArray[indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.commentLLL.text = comment.commentContent;
//    cell.userNL .text = comment.commentBy.username;
#warning LefttavleView-----------
    cell.comment = comment;
    
//    AVFile *ff = [AVFile fileWithURL:self.titlestring];
//    [ff getThumbnail:YES width:200 height:200 withBlock:^(UIImage *image, NSError *error) {
//        [cell.iconimv  setImage:image forState:(UIControlStateNormal)];
//    }];
    return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 282;
}

-(void)add {
    
    SWActivityList *activity = [SWActivityList object];
    activity.title = @"招黑体质霉霉又撕逼了，这次是因为歧视女性？ "; // 标题
    activity.content = @"泰勒又火了，这次是和侃爷因为新歌的歌词开战，还附带把卡戴珊、水果姐等风云人物卷了进来。这股火直接从欧美圈一路烧到了中国，来势汹汹、气势惊人。 事情的导火索，是侃爷的新歌——《famous》，这首歌里的一句rap写到了霉霉：“I feel like me and Taylor might still have sex , Why I made that bitch famous god damn . I made that bitch famou”翻译过来就是：“我觉得泰勒应该在床上满足我，她可是老子捧红的，我的老天爷，她可是沾了我的光才红起来的”（我选了一个比较温和的翻译版本，毕竟我们都还是宝宝），在后来公布的新歌MV里，霉霉的蜡像赤身裸体躺在侃爷身边，其实MV里共出现了12个女人的裸体蜡像，包括他老婆卡戴珊的果体。 你怎么看待霉霉和侃爷撕逼这件事？卡戴珊不经霉霉允许就私自录像，但如果没有录像，大家也看不到事情的全貌 霉霉说侃爷这首歌是歧视女性，你怎么看？（"; // 内容
    activity.subhead = @"请自行搜索《famous》）道理我都懂，但我真正关心的是，我森怎么想?"; // 副标题
    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"tl.jpg"], 0.5);
    AVFile *file = [AVFile fileWithName:@"title.jpg" data:data]; // 图片
    [activity setObject:file forKey:@"titleImage"];
    activity.rule = @"一起聊聊"; // 规则
    activity.label = @"娱乐"; // 标签
    activity.point = [AVGeoPoint geoPointWithLatitude:39.57 longitude:116]; // 坐标
    
    activity.markC = @0; // 收藏数累计，默认0
    [activity setObject:[SWLcAvUSer currentUser] forKey:@"createBy"]; // 发布者
    [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        SWLog(@" ---- error %@",error);
        if (succeeded) {
            SWLog(@" ----- succeeded %d",succeeded);
        }
    }];
    
    
    
    //- (void)setString:(NSString *)string {
    //
    //
    //    /**
    //     *  头像
    //     */
    // self.icon = @"";
    //
    //    /**
    //     *  内容
    //     */
    //    self.contL.text = string;
    //    /**
    //     *  标签
    //     */
    //   self.biaoQL.text = string;
    //    /**
    //     *  标题
    //     */
    //   self.titleL.text = string;
    //
    //    /**
    //     *  副标题
    //     */
    //   self.detail.text = string;
    //    /**
    //     *  详情图片
    //     */
    //  self.imageV = @"";
    //    /**
    //     *  一起聊聊
    //     */
    //  self.xzLable.text = string;
    //
    //    self.userName.text = string;
    //}
    //
    
}
- (void)animalCancle {
    
    self.btn.selected = NO;
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
}
-(void)animalAdd {
    
    
    
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
    
    self.btn.selected = YES;
    
    UILabel *lableV  = [self.view viewWithTag:333];
    [lableV removeFromSuperview];
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(disapperAction) userInfo:nil repeats:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources tha1t can be recreated.
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
