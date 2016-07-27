//
//  SWUserDetailViewController.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/16.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseViewController.h"

@interface SWUserDetailViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *headerView;
//收藏数
@property (strong, nonatomic) IBOutlet UILabel *praiseL;
//被收藏数
@property (strong, nonatomic) IBOutlet UILabel *bepraisel;
//被推荐数
@property (strong, nonatomic) IBOutlet UILabel *focusL;
@property (strong, nonatomic) IBOutlet UILabel *befocus;

@property (strong, nonatomic) IBOutlet UIImageView *iconI;
@property (strong, nonatomic) IBOutlet UILabel *nameL;
@property (strong, nonatomic) IBOutlet UILabel *genderL;

@property (nonatomic,strong) NSString *userString;

@end
