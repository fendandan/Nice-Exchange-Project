//
//  SWNotfcTableViewCell.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWNotfcTableViewCell.h"

@implementation SWNotfcTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addScreening];
    }
    return self;
}


-(void)addScreening{
    /*
    self.emptyImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    self.emptyImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.emptyImage];
    
    //self.titleblabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.emptyImage.frame)+20, 10, 300, 30)];
    self.titleblabel = [[UILabel alloc]init];
    self.titleblabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.titleblabel];
    */
   
    
    
    self.yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.yesButton.frame = CGRectMake(10, 10, 30, 30);
    [self.yesButton setImage:[UIImage imageNamed:@"practise_a_n_day.png"] forState:UIControlStateNormal];
    [self.yesButton setImage:[UIImage imageNamed:@"practise_a_s_day"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.yesButton];
    self.yesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.yesButton.frame)+20, CGRectGetMinY(self.yesButton.frame), 300, 30)];
    
    //self.yesLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.yesLabel];
    self.noButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.noButton.frame = CGRectMake(CGRectGetMinX(self.yesButton.frame), CGRectGetMaxY(self.yesButton.frame)+10, self.yesButton.frame.size.width, self.yesButton.frame.size.height);
    [self.noButton setImage:[UIImage imageNamed:@"practise_b_n_day.png"] forState:UIControlStateNormal];
    [self.noButton setImage:[UIImage imageNamed:@"practise_b_s_day"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.noButton];
    self.noLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.noButton.frame)+20, CGRectGetMinY(self.noButton.frame), 300, 30)];
    //self.noLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.noLabel];
    
}

-(void)layoutSubviews{
    //self.emptyImage.frame = CGRectMake(20, 10, 30, 30);
    //self.titleblabel.frame = CGRectMake(CGRectGetMaxX(self.emptyImage.frame)+20, 10, 300, 30);
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
