//
//  MSGuideViewCell.h
//  MSGuideViewDemo
//
//  Created by Spacewalk on 16/7/19.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//
#import <UIKit/UIKit.h>

static NSString *kCellIdentifier_MsGuideViewCell = @"HcdGuideViewCell";

@interface MsGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@end
