//
//  MusicListCell.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/15.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicInfo.h"
@interface MusicListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;  //背景视图

@property (weak, nonatomic) IBOutlet UIImageView *musicImageView; //音乐图片
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;  //歌曲名标签
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel; //歌手名标签
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;     //专辑

@property (strong, nonatomic) MusicInfo * music;
@end
