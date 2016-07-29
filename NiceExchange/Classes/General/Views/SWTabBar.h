//
//  SWTabBar.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWTabBar;
@protocol SWTabBarDelegate <NSObject>

- (void)swTabBarItemDidClicked:(SWTabBar *)tabBar;
-(void)swMessTabBarItemDidClicked:(SWTabBar *)sender;
@end

@interface SWTabBar : UITabBar


/// 当前选中的tabBar（标号）
@property (assign, nonatomic) int currentSelected;

/// 当前选中的tabBarItem（实体）
@property (strong, nonatomic) UIButton *currebtSelectedItem;

/// tabBar上所有的item
@property (strong, nonatomic) NSArray *allItems;

@property (weak, nonatomic) id<SWTabBarDelegate> swDelegete;

/// 初始化方法：根据items初始化tabBar
- (instancetype)initWithItems:(NSArray *)items frame:(CGRect)frame;


@end
