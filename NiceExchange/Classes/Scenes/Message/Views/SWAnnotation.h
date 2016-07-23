//
//  SWAnnotation.h
//  NiceExchange
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWAnnotation : NSObject
<
BMKAnnotation
>

// 坐标
@property (nonatomic) CLLocationCoordinate2D coordinate;

// 标题
@property (nonatomic, copy) NSString *title;

// 子标题
@property (nonatomic, copy) NSString *subtitle;

/*** 大头针图标 */
@property (nonatomic, strong) UIImage *icon ;


@end
