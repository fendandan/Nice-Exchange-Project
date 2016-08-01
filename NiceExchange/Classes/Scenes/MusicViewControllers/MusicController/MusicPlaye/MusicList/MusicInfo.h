//
//  MusicInfo.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/16.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicInfo : NSObject
{
    NSInteger _id; //受保护的
}
@property (nonatomic, copy) NSString *mp3Url; //播放路径
@property (nonatomic) NSInteger Id; //id
@property (nonatomic, copy) NSString *name; //歌曲的名字
@property (nonatomic, copy) NSString *picUrl; //歌曲图片路径
@property (nonatomic, copy) NSString *blurPicUrl;   //模糊图
@property (nonatomic, copy) NSString *album; //专辑
@property (nonatomic, copy) NSString *singer;   //歌手
@property (nonatomic, assign) NSInteger duration; //时长 单位 ms
@property (nonatomic, copy) NSString *artists_name; //艺名
@property (nonatomic, copy) NSString *lyric; //歌词

@end
