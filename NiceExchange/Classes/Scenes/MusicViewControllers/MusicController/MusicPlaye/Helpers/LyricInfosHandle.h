//
//  LyricInfosHandle.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/18.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "RowLyricInfo.h"
@interface LyricInfosHandle : NSObject

//声明单例对象
singleton_interface(LyricInfosHandle);
/**
 *  解析歌词
 *
 *  @param lyricString 歌词字符串
 *
 *  @return 存放行歌词对象的数组
 */
- (NSArray *)lyricsWithLyricString:(NSString *)lyricString;
/**
 *  根据歌词数组返回分区section个数
 *
 *  @return 分区数
 */
- (NSInteger)numberOfSections;
/**
 *  获取指定分区section下有多少行
 *
 *  @param section 指定分区
 *
 *  @return 行数
 */
- (NSInteger)numberofRowsInSection:(NSInteger)section;
/**
 *  根据指定的indexPath获取某个歌词对象
 *
 *  @param indexPath 【section,row】
 *
 *  @return 行歌词对象
 */
- (RowLyricInfo *)rowLyricInfoForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  获取当前播放到的歌词对应的index
 *
 *  @param time time
 *
 *  @return index
 */
- (NSInteger)indexForRowByTime:(CGFloat)time;





@end
