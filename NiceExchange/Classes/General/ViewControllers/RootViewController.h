//
//  RootViewController.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWTabBar;
@interface RootViewController : UITabBarController

@property (nonatomic,strong) SWTabBar * swTabBar;

@property (strong, nonatomic) NSMutableArray *followArray;
@property (strong, nonatomic) NSMutableArray *followedArray;

@property (nonatomic,assign)BOOL state;

@end
