//
//  BaseSwitchViewController.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseViewController.h"



@interface BaseSwitchViewController : BaseViewController
@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UITableView *leftTableView;
@property (strong, nonatomic) UITableView *rightTableView;

@property (strong, nonatomic) NSMutableArray *leftDataArray;
@property (strong, nonatomic) NSMutableArray *rightDataArray;


@end
