//
//  MusicViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIScrollView *ScrollViewnNav;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addScrollView];
    
    [self addScrollViewnNavigation];
    
    
    
    
    //注册头部视图
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
}




//添加导航栏
- (void)addScrollViewnNavigation
{
    self.ScrollViewnNav = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 50)];
    
    self.ScrollViewnNav.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.ScrollViewnNav];
    
    
    //添加导航按钮
    UIButton *musicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [musicBtn setTitle:@"音乐" forState:(UIControlStateNormal)];
    musicBtn.frame = CGRectMake(10, 0, 50, 50);
    [self.ScrollViewnNav addSubview:musicBtn];
    
    [musicBtn addTarget:self action:@selector(musicBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *readBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [readBtn setTitle:@"阅读" forState:(UIControlStateNormal)];
    readBtn.frame = CGRectMake(100, 0, 50, 50);
    [self.ScrollViewnNav addSubview:readBtn];
    
    [readBtn addTarget:self action:@selector(readBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *movieBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [movieBtn setTitle:@"视频" forState:(UIControlStateNormal)];
    movieBtn.frame = CGRectMake(180, 0, 50, 50);
    [self.ScrollViewnNav addSubview:movieBtn];
    
    [movieBtn addTarget:self action:@selector(movieBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}



//音乐点击事件
- (void)musicBtnAction:(UIButton *)sender
{
    
    NSLog(@"音乐");
    
}


//阅读点击事件
- (void)readBtnAction:(UIButton *)sender
{
    NSLog(@"阅读");
}


//视频点击事件
- (void)movieBtnAction:(UIButton *)sender
{
    NSLog(@"视频");
}







//添加轮播图
- (UIScrollView *)addScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 540)];
    
//    [self.view addSubview:self.scrollView];

    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    
    self.scrollView.pagingEnabled = YES;
    
    // 代理
    self.scrollView.delegate = self;
    
    //轮播图布局
    for (NSInteger i = 1; i < 5; i ++) {
        UIImageView *imageV  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width,self.view.frame.size.height - 540)];
        imageV.backgroundColor = [UIColor cyanColor];
        
        [self.scrollView addSubview:imageV];
    }
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(160, 250, 100, 30)];
    
    [self.collectionview addSubview:self.pageControl];
    
    self.pageControl.numberOfPages = 5;
//    self.pageControl.backgroundColor = [UIColor whiteColor];
    
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:109/255.0 green:215/255.0 blue:248/255.0 alpha:1];
    
    [self.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return self.scrollView;
}




//点击 page 页面动
- (void)pageControlAction:(UIPageControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(414 * sender.currentPage, 0) animated:YES];

}




//滑动页面 page 动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        NSLog(@"page 代理方法");
        
        self.pageControl.currentPage = self.scrollView.contentOffset.x/414;
    }
    
}












////头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 0) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        
        
        [headerView addSubview:[self addScrollView]];
        
        return headerView;
        
    }else
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 287, 100, 30)];
        
        titleLabel.backgroundColor = [UIColor greenColor];
        
        titleLabel.text = @"歌单推荐";
        
        [headerView addSubview:titleLabel];
        
        
        
        UIButton *moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        moreBtn.frame = CGRectMake(359, 287, 50, 30);
        
        moreBtn.backgroundColor = [UIColor orangeColor];
        
        [moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
        
        [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [headerView addSubview:moreBtn];
        
        
        return headerView;
    }
 
}



// 设置 collectionView 头部视图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        
        return CGSizeMake(self.view.frame.size.width, 320);
    }
    
    return CGSizeMake(self.view.frame.size.width, 0);
    
}



//button 点击事件
- (void)moreBtnAction:(UIButton *)sender
{
    
    NSLog(@"更多音乐");
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
