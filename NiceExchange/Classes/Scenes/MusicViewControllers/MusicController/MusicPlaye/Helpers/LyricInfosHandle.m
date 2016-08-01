//
//  LyricInfosHandle.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/18.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "LyricInfosHandle.h"
#import <UIKit/UIKit.h>
#import "RowLyricInfo.h"

@interface LyricInfosHandle ()

@property (nonatomic,strong) NSMutableArray * allRowsLyricInfoArray; //存放所有rowLyricInfo对象
@end

@implementation LyricInfosHandle
//实现单例对象
singleton_implementaton(LyricInfosHandle)
/**
 *  解析歌词
 *
 *  @param lyricString 歌词字符串
 *
 *  @return 存放行歌词对象的数组
 */
- (NSArray *)lyricsWithLyricString:(NSString *)lyricString
{
    //每次解析之前，要将数组清空一下
    [self.allRowsLyricInfoArray removeAllObjects];
    
   NSArray * allRowsLyric = [lyricString componentsSeparatedByString:@"\n"];
    for (NSString * rowLyric in allRowsLyric) {
        if (rowLyric.length != 0) {
            //        [“[01:303”,“Yes please”]
            NSArray * timeAndLyricStr = [rowLyric componentsSeparatedByString:@"]"];
            //        [ "01","303" ]
            NSArray * timeStrArray = [[timeAndLyricStr[0] substringFromIndex:1] componentsSeparatedByString:@":"];
            CGFloat time = [timeStrArray[0] integerValue] * 60 + [timeStrArray[1] floatValue];
            NSString * rowLyricStr = timeAndLyricStr[1];
            //        NSDictionary * dic = @{@"time":time,@"rowLyricStr":rowLyricStr};
            RowLyricInfo * lyric = [RowLyricInfo rowLyricWithRowLyricStr:rowLyricStr time:time];
            [self.allRowsLyricInfoArray addObject:lyric];
        }
    }
    return _allRowsLyricInfoArray;
}
/**
 *  懒加载初始化数组
 */
- (NSMutableArray *)allRowsLyricInfoArray
{
    if (!_allRowsLyricInfoArray) {
        _allRowsLyricInfoArray = [NSMutableArray array];
    }
    return _allRowsLyricInfoArray;
}
/**
 *  根据歌词数组返回分区section个数
 *
 *  @return 分区数
 */
- (NSInteger)numberOfSections
{
    return 1;
}
/**
 *  获取指定分区section下有多少行
 *
 *  @param section 指定分区
 *
 *  @return 行数
 */
- (NSInteger)numberofRowsInSection:(NSInteger)section
{
   return self.allRowsLyricInfoArray.count;
}
/**
 *  根据指定的indexPath获取某个歌词对象
 *
 *  @param indexPath 【section,row】
 *
 *  @return 行歌词对象
 */
- (RowLyricInfo *)rowLyricInfoForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _allRowsLyricInfoArray[indexPath.row];
}
/**
 *  获取当前播放到的歌词对应的index
 *
 *  @param time time
 *
 *  @return index
 */
- (NSInteger)indexForRowByTime:(CGFloat)time
{
    for (int i = 0; i < _allRowsLyricInfoArray.count; i++) {
        if ([_allRowsLyricInfoArray[i] time] > time) {
            return (i-1 > 0) ? i-1 : 0;
        }
    }
    return _allRowsLyricInfoArray.count - 1;
}







@end
