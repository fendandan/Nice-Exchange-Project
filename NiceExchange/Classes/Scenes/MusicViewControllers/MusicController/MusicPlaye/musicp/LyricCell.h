//
//  LyricCell.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/18.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LyricCell : UITableViewCell
@property (nonatomic, strong)UILabel * lyricLabel;//显示歌词标签
//计算cell的高度
+ (CGFloat)heightForCellWithLyric:(NSString *)lyric;





@end
