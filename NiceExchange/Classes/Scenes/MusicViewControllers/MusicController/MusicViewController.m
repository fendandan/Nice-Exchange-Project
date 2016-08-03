//
//  MusicViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MusicViewController.h"
#import "ScrollViewController.h"
#import "RedaViewController.h"
#import "MovieViewController.h"
#import "MoodViewController.h"
#import "ElseViewController.h"

#import "OneScrollViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "MusicDetailViewController.h"

@interface MusicViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIScrollView *ScrollViewnNav;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIView *collectionHeaderView;

@property(nonatomic,strong)UIScrollView *BottomScrollView;

@property(nonatomic,strong)NSMutableArray *musicArray;
@property(nonatomic,strong)NSMutableArray *oneArray;
@property(nonatomic,strong)NSMutableArray *twoArray;
@property(nonatomic,strong)NSMutableArray *threeArray;
@property(nonatomic,strong)NSMutableArray *fourArray;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *titleArray;


@property(nonatomic,strong)UIButton *musicBtn;
@property(nonatomic,strong)UIButton *readBtn;
@property(nonatomic,strong)UIButton *lohasBtn;
@property(nonatomic,strong)UIButton *moodBtn;
@property(nonatomic,strong)UIButton *elseBtn;

@property(nonatomic,strong)NSTimer *timer;


@property(nonatomic,strong)NSArray *urlArray;
@property(nonatomic,strong)NSArray *onesectionArr;
@property(nonatomic,strong)NSArray *twosectionArr;
@property(nonatomic,strong)NSArray *threesectionArr;
@property(nonatomic,strong)NSArray *foursectionArr;


@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加底层滚动视图
    [self addScrollView];
    [self.collectionview removeFromSuperview];
    [self.BottomScrollView addSubview:self.collectionview];
    
    //添加导航 scrollView
    [self addScrollViewnNavigation];
    
    
    //注册头部视图
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
//    //分区头视图
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1"];
    
    
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];
    
    
    
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView3"];

#warning -----
    //请求数据
    [self MusicRequestData];
    
    
    self.musicBtn.selected = YES;
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
    
    self.onesectionArr = @[MusicOneSectionRequest_Url1,MusicOneSectionRequest_Url2,MusicOneSectionRequest_Url3,MusicOneSectionRequest_Url4,MusicOneSectionRequest_Url5,MusicOneSectionRequest_Url6];
    
    
    self.twosectionArr = @[MusicTwoSectionRequest_Url2,MusicTwoSectionRequest_Url1,MusicTwoSectionRequest_Url3,MusicTwoSectionRequest_Url4,MusicTwoSectionRequest_Url5,MusicTwoSectionRequest_Url6];
    
    self.threesectionArr = @[MusicThreeSectionRequest_Url1,MusicThreeSectionRequest_Url2,MusicThreeSectionRequest_Url3,MusicThreeSectionRequest_Url4,MusicThreeSectionRequest_Url5,MusicThreeSectionRequest_Url6];
    
    self.foursectionArr = @[MusicFourSectionRequest_Url1,MusicFourSectionRequest_Url2,MusicFourSectionRequest_Url3,MusicFourSectionRequest_Url4,MusicFourSectionRequest_Url5,MusicFourSectionRequest_Url6];
    
    self.urlArray = @[self.onesectionArr,self.twosectionArr,self.threesectionArr,self.foursectionArr];

}



//添加底层scrollView
- (void)addScrollView
{
    self.BottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.BottomScrollView.pagingEnabled = YES;
    
    self.BottomScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    

    //添加 view
    RedaViewController *readVC = [[RedaViewController alloc] init];
    readVC.view.frame = CGRectMake(kScreenWidth, 80, kScreenWidth, kScreenHeight - 80);
    [self addChildViewController:readVC];
    [self.BottomScrollView addSubview:readVC.view];
    
    MovieViewController *movieVC = [[MovieViewController alloc] init];
    movieVC.view.frame = CGRectMake(kScreenWidth*2, 80, kScreenWidth, kScreenHeight - 80);
    [self addChildViewController:movieVC];
    [self.BottomScrollView addSubview:movieVC.view];
    
    
    MoodViewController *moodVC = [[MoodViewController alloc] init];
    moodVC.view.frame = CGRectMake(kScreenWidth*3, 80, kScreenWidth, kScreenHeight - 80);
    [self addChildViewController:moodVC];
    [self.BottomScrollView addSubview:moodVC.view];

    
    ElseViewController *elseVC = [[ElseViewController alloc] init];
    elseVC.view.frame = CGRectMake(kScreenWidth*4, 80, kScreenWidth, kScreenHeight - 80);
    [self addChildViewController:elseVC];
    [self.BottomScrollView addSubview:elseVC.view];
    
    
    self.BottomScrollView.delegate = self;
    
    [self.view addSubview:self.BottomScrollView];
}










//请求推荐页面数据
- (void)MusicRequestData
{
    self.musicArray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    
    MusicRequest *request = [MusicRequest new];
    
    [request musicRequestparameter:nil success:^(NSDictionary *dic) {
        
        NSDictionary *data = [dic objectForKey:@"data"];
        
        NSMutableArray *list = [data objectForKey:@"list"];
        
        NSInteger i = 0;
        
        for (NSDictionary *tempDIC in list) {
            
            NSMutableArray *collectionsArray = [tempDIC objectForKey:@"collections"];
            
            if (i==list[3] || i==list[4] || i==list[6]|| i==list[7]) {
                
               [self.titleArray addObject:[tempDIC objectForKey:@"title"]];
            }
        
            
            for (NSDictionary *DIC in collectionsArray) {
           
                MusicModel *model = [MusicModel new];
             
                [model setValuesForKeysWithDictionary:DIC];
                
                [self.musicArray addObject:model];
             
            }
            i++;
        }
        
        
        self.oneArray = [NSMutableArray new];
        for (int i = 0; i < 6; i++) {
            [self.oneArray addObject:self.musicArray[i]];

        }

        self.twoArray = [NSMutableArray new];
        for (int i = 6; i < 12; i++) {
            [self.twoArray addObject:self.musicArray[i]];
            
        }
        
        self.threeArray = [NSMutableArray new];
        for (int i =12; i < 18; i++) {
            [self.threeArray addObject:self.musicArray[i]];
            
        }
        
        self.fourArray = [NSMutableArray new];
        for (int i = 18; i < 24; i++) {
            [self.fourArray addObject:self.musicArray[i]];
        }
        
        self.dataArray = @[self.oneArray,self.twoArray,self.threeArray,self.fourArray];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionview reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}






-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
//    if (self.oneArray) {
//        return self.titleArray[0];
//    }
   
    
   
    
    return self.titleArray.count;
   
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return self.twoArray.count;
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseOrganCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"baseCell" forIndexPath:indexPath];
    
    MusicModel *model = self.dataArray[indexPath.section][indexPath.row];

    NSString *string = model.logo;
    
    NSRange range = [string rangeOfString:@"@"];
    
    NSString *str = [string substringToIndex:range.location];

    [cell.baseImv setImageWithURL:[NSURL URLWithString:str]];
    
    cell.baseLable.text = model.name;
    
    cell.baseLable.numberOfLines = 0;
    
    return cell;
}




//添加导航栏
- (void)addScrollViewnNavigation
{
    self.ScrollViewnNav = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 50)];
    
    self.ScrollViewnNav.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.ScrollViewnNav];
    
    
    //添加导航按钮
    _musicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_musicBtn setTitle:@"音乐" forState:(UIControlStateNormal)];
    [_musicBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _musicBtn.frame = CGRectMake(10, 0, 50, 50);
    _musicBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.ScrollViewnNav addSubview:_musicBtn];
    
    [_musicBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
    [_musicBtn addTarget:self action:@selector(musicBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
    _readBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_readBtn setTitle:@"文艺" forState:(UIControlStateNormal)];
    [_readBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _readBtn.frame = CGRectMake(100, 0, 50, 50);
    [self.ScrollViewnNav addSubview:_readBtn];
    _readBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_readBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
    [_readBtn addTarget:self action:@selector(readBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    _lohasBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_lohasBtn setTitle:@"乐活" forState:(UIControlStateNormal)];
    [_lohasBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _lohasBtn.frame = CGRectMake(190, 0, 50, 50);
    [self.ScrollViewnNav addSubview:_lohasBtn];
    _lohasBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_lohasBtn addTarget:self action:@selector(lohasBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_lohasBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
    
    
    
    
    _moodBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_moodBtn setTitle:@"心情" forState:(UIControlStateNormal)];
    [_moodBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _moodBtn.frame = CGRectMake(280, 0, 50, 50);
    [self.ScrollViewnNav addSubview:_moodBtn];
    _moodBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_moodBtn addTarget:self action:@selector(moodBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_moodBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
    
    

    _elseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_elseBtn setTitle:@"其他" forState:(UIControlStateNormal)];
    [_elseBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _elseBtn.frame = CGRectMake(360, 0, 50, 50);
    [self.ScrollViewnNav addSubview:_elseBtn];
    _elseBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_elseBtn addTarget:self action:@selector(elseBtnBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_elseBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateSelected)];
    
}





//音乐点击事件
- (void)musicBtnAction:(UIButton *)btn
{
    btn.selected = YES;
    self.readBtn.selected = NO;
    self.lohasBtn.selected = NO;
    self.moodBtn.selected = NO;
    self.elseBtn.selected = NO;
    self.BottomScrollView.contentOffset = CGPointMake(self.BottomScrollView.frame.size.width/414, 0);
}


//阅读点击事件
- (void)readBtnAction:(UIButton *)btn
{
    self.musicBtn.selected = NO;
    btn.selected = YES;
    self.lohasBtn.selected = NO;
    self.moodBtn.selected = NO;
    self.elseBtn.selected = NO;
    self.BottomScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
}


//乐活点击事件
- (void)lohasBtnAction:(UIButton *)btn
{
    self.musicBtn.selected = NO;
    self.readBtn.selected = NO;
    btn.selected = YES;
    self.moodBtn.selected = NO;
    self.elseBtn.selected = NO;
    self.BottomScrollView.contentOffset = CGPointMake(kScreenWidth * 2, 0);
}


//心情点击事件
- (void)moodBtnAction:(UIButton *)btn
{
    self.musicBtn.selected = NO;
    self.readBtn.selected = NO;
    self.lohasBtn.selected= NO;
    btn.selected = YES;
    self.elseBtn.selected = NO;
    self.BottomScrollView.contentOffset = CGPointMake(kScreenWidth * 3, 0);
    
}



//其他点击事件
- (void)elseBtnBtnAction:(UIButton *)btn
{
    self.musicBtn.selected = NO;
    self.readBtn.selected = NO;
    self.lohasBtn.selected= NO;
    self.moodBtn.selected = NO;
    btn.selected = YES;
    self.BottomScrollView.contentOffset = CGPointMake(kScreenWidth * 4, 0);
}




//添加轮播图
- (UIScrollView *)addscrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 540)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    self.scrollView.pagingEnabled = YES;
    // 代理
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    
    
    //轮播图布局
    for (NSInteger i = 1; i < 6; i ++) {
        UIImageView *imageV  = [[UIImageView alloc] initWithFrame:CGRectMake((i-1)*kScreenWidth, 30, kScreenWidth,kScreenHeight - 540)];
//        imageV.backgroundColor = [UIColor cyanColor];
        imageV.userInteractionEnabled = YES;
        
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",i]];
        
        
        //imageView 的点击事件
        for (int i = 1; i < 6; i++) {
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
            [imageV addGestureRecognizer:singleTap];
            [self.scrollView addSubview:imageV];
        }
        
    }
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(160, 250, 100, 30)];
    [self.collectionview addSubview:self.pageControl];
    self.pageControl.numberOfPages = 5;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:109/255.0 green:215/255.0 blue:248/255.0 alpha:1];
    [self.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    return self.scrollView;
}



int a = 0;
- (void)timerAction{
    a++;
    if (a == 5) {
        a = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(414*a, 0)];
    
    [self.pageControl setCurrentPage:a];
    
}




//点击imageView 跳转页面
- (void)action:(UITapGestureRecognizer *)sender
{
    
    if (self.scrollView.contentOffset.x == 0) {
        
        ScrollViewController *scrVC = [ScrollViewController new];
        
        [self.navigationController pushViewController:scrVC animated:YES];
        
    }else if (self.scrollView.contentOffset.x == 414) {
        
        OneScrollViewController *oneVC = [OneScrollViewController new];
        
        [self.navigationController pushViewController:oneVC animated:YES];
    }else if (self.scrollView.contentOffset.x == kScreenWidth * 2) {
        
        TwoViewController *twoVC = [TwoViewController new];
        
        [self.navigationController pushViewController:twoVC animated:YES];
        
    }else if (self.scrollView.contentOffset.x == kScreenWidth * 3) {
        
        ThreeViewController *threeVC = [ThreeViewController new];
        
        [self.navigationController pushViewController:threeVC animated:YES];
    }else if (self.scrollView.contentOffset.x == kScreenWidth * 4) {
        
        FourViewController *fourVC = [FourViewController new];
        
        [self.navigationController pushViewController:fourVC animated:YES];
    }
    
   
    

}







//点击 page 页面动
- (void)pageControlAction:(UIPageControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(414 * sender.currentPage, 0) animated:YES];

}




//滑动页面 page 动(当滚动视图停止的时候)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        NSLog(@"page 代理方法");
        
        self.pageControl.currentPage = self.scrollView.contentOffset.x/kScreenWidth;
    }else if (scrollView == self.BottomScrollView)
    {
        int i = self.BottomScrollView.contentOffset.x/kScreenWidth;
        if (i == 0) {
            
            self.musicBtn.selected = YES;
            self.readBtn.selected = NO;
            self.lohasBtn.selected = NO;
            self.moodBtn.selected = NO;
            self.elseBtn.selected = NO;
            
        }else if (i == 1) {
            
            self.musicBtn.selected = NO;
            self.readBtn.selected = YES;
            self.lohasBtn.selected = NO;
            self.moodBtn.selected = NO;
            self.elseBtn.selected = NO;
            
        }else if (i == 2) {

            self.musicBtn.selected = NO;
            self.readBtn.selected = NO;
            self.lohasBtn.selected = YES;
            self.moodBtn.selected = NO;
            self.elseBtn.selected = NO;
            
        }else if (i == 3) {
            
            self.musicBtn.selected = NO;
            self.readBtn.selected = NO;
            self.lohasBtn.selected = NO;
            self.moodBtn.selected = YES;
            self.elseBtn.selected = NO;
            
        }else if (i == 4) {
            
            self.musicBtn.selected = NO;
            self.readBtn.selected = NO;
            self.lohasBtn.selected = NO;
            self.moodBtn.selected = NO;
            self.elseBtn.selected = YES;
            
        }
    }
}




////头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ( indexPath.section == 0) {
    
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        //添加轮播视图
        [headerView addSubview:[self addscrollView]];
        
        //collectionView 分区视图
        self.collectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 275, self.view.frame.size.width, 30)];
        
        [headerView addSubview:self.collectionHeaderView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
        [self.collectionHeaderView addSubview:titleLabel];
        
        titleLabel.text = self.titleArray[0];
        

        return headerView;
        
    }
    else if (indexPath.section == 1)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1" forIndexPath:indexPath];
        
        //collectionView 分区视图
        self.collectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];

        [headerView addSubview:self.collectionHeaderView];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        
        titleLabel.text = self.titleArray[1];
        
        [self.collectionHeaderView addSubview:titleLabel];
        
        return headerView;
    }else if (indexPath.section == 2) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2" forIndexPath:indexPath];
        
        //collectionView 分区视图
        self.collectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        
        [headerView addSubview:self.collectionHeaderView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        
        titleLabel.text = self.titleArray[2];
        
        [self.collectionHeaderView addSubview:titleLabel];
        
        return headerView;
    }else if (indexPath.section == 3) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView3" forIndexPath:indexPath];
        
        //collectionView 分区视图
        self.collectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        
        [headerView addSubview:self.collectionHeaderView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        
        titleLabel.text = self.titleArray[3];
        
        [self.collectionHeaderView addSubview:titleLabel];
        
        return headerView;
    }
    return nil;
}



// 设置 collectionView 头部视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        return CGSizeMake(self.view.frame.size.width, 320);
    }
    
    return CGSizeMake(self.view.frame.size.width, 30);
    
}








// 选中操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicDetailViewController *dteaVC = [MusicDetailViewController new];
    
    dteaVC.urlString = self.urlArray[indexPath.section][indexPath.row];
    
    MusicModel *model = self.dataArray[indexPath.section][indexPath.row];
    
    NSString *string = model.logo;
    
    dteaVC.detailImage = string;
    

    [self.navigationController pushViewController:dteaVC animated:YES];
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
