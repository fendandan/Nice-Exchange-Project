//
//  LyricCell.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/18.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "LyricCell.h"

@implementation LyricCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"+++++%@,---%@",NSStringFromCGRect(self.contentView.frame),NSStringFromCGRect(self.frame));

        self.lyricLabel = [[UILabel alloc] init];
        
        _lyricLabel.numberOfLines = 0;
        _lyricLabel.textAlignment = NSTextAlignmentCenter;
        _lyricLabel.font = [UIFont systemFontOfSize:15.0];
        _lyricLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_lyricLabel];
        //取消cell的选中状态
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lyricLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    NSLog(@"+++++%@,---%@",NSStringFromCGRect(self.contentView.frame),NSStringFromCGRect(self.frame));
}



//计算cell的高度
+ (CGFloat)heightForCellWithLyric:(NSString *)lyric
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000);
    CGRect rect = [lyric boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}







@end
