//
//  MusicViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MusicViewController.h"
#import "ScrollViewController.h"

@interface MusicViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIScrollView *ScrollViewnNav;
@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)UIView *collectionHeaderView;

@property(nonatomic,strong)NSMutableArray *musicArray;

@property(nonatomic,strong)NSMutableArray *oneArray;

@property(nonatomic,strong)NSMutableArray *twoArray;
@property(nonatomic,strong)NSMutableArray *threeArray;
@property(nonatomic,strong)NSMutableArray *fourArray;
@property(nonatomic,strong)NSArray *dataArray;


@property(nonatomic,strong)NSMutableArray *titleArray;


@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addScrollViewnNavigation];
    
    
    
    
    //注册头部视图
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
//    //分区头视图
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

    
    [self MusicRequestData];
    

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
            
            if (i==4 || i==5 || i==7 || i==8) {
                
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
    return self.titleArray.count;
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        return 6;
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
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    self.scrollView.pagingEnabled = YES;
    // 代理
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    
    
    //轮播图布局
    for (NSInteger i = 1; i < 5; i ++) {
        UIImageView *imageV  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width,self.view.frame.size.height - 540)];
        imageV.backgroundColor = [UIColor cyanColor];
        imageV.userInteractionEnabled = YES;
        
        //imageView 的点击事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
        [imageV addGestureRecognizer:singleTap];
        
        [self.scrollView addSubview:imageV];
    }
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(160, 250, 100, 30)];
    [self.collectionview addSubview:self.pageControl];
    self.pageControl.numberOfPages = 5;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:109/255.0 green:215/255.0 blue:248/255.0 alpha:1];
    [self.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    return self.scrollView;
}





//点击imageView 跳转页面
- (void)action:(UITapGestureRecognizer *)sender
{
   
        ScrollViewController *scrVC = [ScrollViewController new];
        
        [self.navigationController pushViewController:scrVC animated:YES];

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
    
    if ( indexPath.section == 0) {
    
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        //添加轮播视图
        [headerView addSubview:[self addScrollView]];
        
        

        
        //collectionView 分区视图
        self.collectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 275, self.view.frame.size.width, 30)];
        

        
        [headerView addSubview:self.collectionHeaderView];
        
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 20)];
        [self.collectionHeaderView addSubview:titleLabel];
        
        titleLabel.text = self.titleArray[0];
        
//        UIButton *moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        moreBtn.frame = CGRectMake(359, 10, 50, 20);
//        moreBtn.backgroundColor = [UIColor orangeColor];
//        [moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
//        [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.collectionHeaderView addSubview:moreBtn];
        
        return headerView;
        
    }
    else
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        //collectionView 分区视图
        self.collectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];

        [headerView addSubview:self.collectionHeaderView];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 20)];
        
        
        
        //label 赋值
            if (indexPath.section == 1) {
                titleLabel.text = self.titleArray[1];
            }else if (indexPath.section == 2){
                titleLabel.text = self.titleArray[2];
            }else if (indexPath.section == 3){
                titleLabel.text = self.titleArray[3];
            }
            
    
        
        
        
        
        [self.collectionHeaderView addSubview:titleLabel];
        
//        UIButton *moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        moreBtn.frame = CGRectMake(359, 5, 50, 20);
//        moreBtn.backgroundColor = [UIColor orangeColor];
//        [moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
//        [moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        [self.collectionHeaderView addSubview:moreBtn];
        
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
