//
//  MusicListCell.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/15.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MusicListCell.h"
@implementation MusicListCell

/**
 *  将cell的子视图赋值
 *
 *  @param music <#music description#>
 */

- (void)setMusic:(MusicInfo *)music
{
    if (_music != music) {
        _music = nil;
        _music = music;
        _musicNameLabel.text = music.name;
        _singerNameLabel.text = music.singer;
        [_musicImageView setImageWithURL:[NSURL URLWithString:music.picUrl] placeholderImage:[UIImage imageNamed:@"songzhongji"]];
        _albumLabel.text = music.album;
    }
}


















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
