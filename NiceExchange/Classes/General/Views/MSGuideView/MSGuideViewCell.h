//
//  HcdGuideViewCell.h
//  HcdGuideViewDemo
//
//  Created by Spacewalk on 16/7/19.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//
#import <UIKit/UIKit.h>

static NSString *kCellIdentifier_HcdGuideViewCell = @"HcdGuideViewCell";

@interface HcdGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@end
