//
//  SWTableViewCell.h
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SWTableViewCell_Cell @"SWTableViewCell_Cell"
@interface SWTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *iconimage;//图标
@property(nonatomic,strong) UILabel *titlelabel; //标题
@property(nonatomic,strong) UILabel *numberlabel;//通知消息个数
@property(nonatomic,strong) UIView *view;
@end
