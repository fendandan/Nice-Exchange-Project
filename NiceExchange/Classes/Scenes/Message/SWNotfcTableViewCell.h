//
//  SWNotfcTableViewCell.h
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SWNotfcTableViewCell_cell @"SWNotfcTableViewCell_cell"
@interface SWNotfcTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *emptyImage;
@property (nonatomic, strong) UILabel *yesLabel;
@property (nonatomic, strong) UILabel *noLabel;
@property (nonatomic, strong) UIButton *yesButton;//
@property (nonatomic, strong) UIButton *noButton;
@end
