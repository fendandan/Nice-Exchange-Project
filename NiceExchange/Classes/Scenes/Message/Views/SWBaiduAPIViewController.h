//
//  SWBaiduAPIViewController.h
//  NiceExchange
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseViewController.h"
#import "SWAnnotation.h"
@interface SWBaiduAPIViewController : BaseViewController
@property (nonatomic,assign)NSInteger longitude;//经度
@property (nonatomic,assign)NSInteger latitude;//纬度
@property (nonatomic,strong)SWAnnotation *an;
@property (nonatomic,strong)NSString *string;
@end
