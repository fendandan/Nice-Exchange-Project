//
//  SWAppDelegate.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *swWindow;
@property (strong, nonatomic)BMKMapManager *mapManager;//百度地图管理器

+ (instancetype)shareSWAppDelegate;

@end
