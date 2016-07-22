//
//  MusicDetailTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicDetailModel.h"

#define MusicDetailTableViewCell_Identifiter @"MusicDetailTableViewCell_Identifiter"

@interface MusicDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *authorLabel;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moreimage;


//@property(nonatomic,strong)MusicDetailModel *model;


@end
