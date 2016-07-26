//
//  SWshowViewController.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseViewController.h"

@interface  SWshowViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *userName;
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIButton *icon;
@property (strong, nonatomic) IBOutlet UIImageView *imagedddddd;

/**
 *  内容
 */
@property (strong, nonatomic) IBOutlet UILabel *contL;
/**
 *  标签
 */
@property (strong, nonatomic) IBOutlet UILabel *biaoQL;
/**
 *  标题
 */
@property (strong, nonatomic) IBOutlet UILabel *titleL;

/**
 *  副标题
 */
@property (strong, nonatomic) IBOutlet UILabel *detail;
/**
 *  详情图片
 */
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
/**
 *  一起聊聊
 */
@property (strong, nonatomic) IBOutlet UILabel *xzLable;

@property (nonatomic,strong)NSString *string;

@property (nonatomic,strong)NSString *titlestring;
@property (nonatomic,strong) UIImage  *dataImage;

@property (strong, nonatomic) SWActivityList *activity;



@end
