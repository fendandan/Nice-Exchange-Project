//
//  SWTableViewCell.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWTableViewCell.h"

@implementation SWTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self addAttribite];
    }
    return self;
}

-(void)addAttribite{
    self.iconimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.iconimage.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.iconimage];
    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconimage.frame.size.width + 20, self.iconimage.frame.origin.y, 260, 50)];
    //self.titlelabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.titlelabel];
    self.numberlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titlelabel.frame.size.width + 100, self.titlelabel.frame.origin.y, 50, 50)];
    //self.numberlabel.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.numberlabel];
    //self.view = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-1,self.bounds.size.width, 1)];
    self.view = [[UIView alloc]init];
    _view.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_view];
    
}

-(void)layoutSubviews{
//    self.iconimage.frame = CGRectMake(10, 10, 50, 50);
//    self.iconimage.backgroundColor = [UIColor grayColor];
//    self.titlelabel.frame = CGRectMake(self.iconimage.frame.size.width + 10, self.iconimage.frame.size.height, 150, 50);
//    self.titlelabel.backgroundColor = [UIColor grayColor];
//    self.numberlabel.frame = CGRectMake(self.bounds.size.width -60 , self.titlelabel.frame.size.height, 50, 50);
//     self.numberlabel.backgroundColor = [UIColor grayColor];
    self.view.frame = CGRectMake(self.titlelabel.frame.origin.x,self.frame.size.height-1,kSelfWidth - 70, 1);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
