//
//  ElseTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/23.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ElseTableViewCell_Identifiter @"ElseTableViewCell_Identifiter"
@interface ElseTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIImageView *BackgroundimageView;

@property (strong, nonatomic) IBOutlet UIButton *collectBtn;

@property (strong, nonatomic) IBOutlet UILabel *collectLabel;

@property (strong, nonatomic) IBOutlet UIButton *participationBtn;

@property (strong, nonatomic) IBOutlet UILabel *participationLabel;

@property (strong, nonatomic) IBOutlet UILabel *subheadingLabel;


@end
