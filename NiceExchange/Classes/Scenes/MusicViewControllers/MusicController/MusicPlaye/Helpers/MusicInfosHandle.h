//
//  MusicInfosHandle.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/16.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "MusicInfo.h"
typedef void(^Completion)(NSArray *array,NSError * error);

@interface MusicInfosHandle : NSObject
//声明单例对象的方法
singleton_interface(MusicInfosHandle);
/**
 *  根据url进行请求，获取所有musicInfo对象
 *
 *  @param urlString  url地址
 *  @param completion 完成之后回调的block
 */
#pragma mark -- 配置音乐列表页面数据源相关操作
- (void)getMusicInfosWithUrl:(NSString *)urlString completion:(Completion)completion;
/**
 *  根据数据源返回多少个section
 *
 *  @return 分区section个数
 */
- (NSInteger)numberOfSections;
/**
 *  根据指定section获取对应多少row
 *
 *  @param section 指定的section
 *
 *  @return row行数
 */
- (NSInteger)numberofRowsInSection:(NSInteger)section;
/**
 *  返回某个分区section下的某行row对应的musicInfo
 *
 *  @param indexPath indexPath
 */
- (MusicInfo *)musicInfoForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark -- 配置播放页面数据源相关操作
/**
 *  获取上一首
 *
 *  @param index 指定歌曲的下标
 *
 *  @return 歌曲对象
 */
- (MusicInfo *)musicInfoLastWithIndex:(NSInteger *)index;
/**
 *  获取下一首
 *
 *  @param index 指定歌曲的下标
 *
 *  @return 歌曲对象
 */
- (MusicInfo *)musicInfoNextWithIndex:(NSInteger *)index;
/**
 *  随机一首歌曲
 *
 *  @return 歌曲对象
 */
- (MusicInfo *)musicInfoOfRandom;





@end
