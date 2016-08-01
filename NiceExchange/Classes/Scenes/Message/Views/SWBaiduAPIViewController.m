//
//  SWBaiduAPIViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaiduAPIViewController.h"

@interface SWBaiduAPIViewController ()
<
BMKMapViewDelegate,
NSURLSessionDelegate,
BMKPoiSearchDelegate
>
{
    CLLocationCoordinate2D *_coor2D;
    BOOL isOrNO;
}

@property(nonatomic,strong)BMKMapView *mapView;//地图
@property (nonatomic,strong)CLLocationManager *manager;//定位管理者
@property (nonatomic,strong)CLGeocoder *geocoder;//编码与反编码
@property (nonatomic,strong)BMKPoiSearch *searcher;
@property (nonatomic,strong)SWAnnotation *annotation;


@end

@implementation SWBaiduAPIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //地图
    [self baiduMapvie];
    //发起检索
    [self nearbysearchoption];
    
    [self addAnnotation];
    
}
//百度地图
-(void)baiduMapvie
{
    //初始化地图
    self.mapView = [[BMKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.mapView;
    // 设置地图的类型
    self.mapView.mapType = BMKMapTypeStandard;
    #warning 用地图同样需要授权
    isOrNO = NO;
    //如果手机不支持定位 直接退出
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    //请求授权
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {// 授权状态不是当使用时获取
        self.manager = [[CLLocationManager alloc]init];
        [self.manager requestWhenInUseAuthorization];
    }
// 设置地图的中心
    //北京 纬度 = 39.904989 经度 = 116.405285
    CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(self.latitude,self.longitude );
    [self.mapView setCenterCoordinate:coor2d];//设置地图的显示范围(中心与经纬度跨度)
    [self.mapView setRegion:BMKCoordinateRegionMake(coor2d, BMKCoordinateSpanMake(0.05,0.05))];
    //显示用户的位置
    //self.mapView.showsUserLocation = YES;
    //设置追踪模式
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    //设置地图旋转
    self.mapView.rotateEnabled = NO;
    //设置代理
    self.mapView.delegate = self;
    
}
//自定义大头针
-(void)addAnnotation
{
    if (!isOrNO) {
        self.an = [[SWAnnotation alloc]init];
        //an.title = @"爱好递归";
        self.an.subtitle = self.string;
        self.an.coordinate = CLLocationCoordinate2DMake(  self.latitude,self.longitude);
        self.an.icon = [UIImage imageNamed:@"1.jpeg"];
        [self.mapView addAnnotation:self.an];
        self.annotation = self.an;
    }else
    {
        isOrNO = NO;
    }
}

 //发起检索
-(void)nearbysearchoption
{
//    _searcher = [[BMKPoiSearch alloc]init];
//    _searcher.delegate = self;
//    //发起检索
//    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//    option.pageCapacity = 2;
//    option.pageIndex = 1;
//    //option.location = CLLocationCoordinate2D{39.915, 116.404}
//    option.location = CLLocationCoordinate2DMake( self.longitude, self.latitude);
//    SWLog(@"%f",option.location.latitude);
//    option.keyword = @"哈哈";
//    BOOL flag = [_searcher poiSearchNearBy:option];
//    if (flag) {
//        SWLog(@"周边检索发送成功");
//    } else
//    {
//        SWLog(@"周边检索发送shi失败");
//    }

 
}
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}
//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
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
