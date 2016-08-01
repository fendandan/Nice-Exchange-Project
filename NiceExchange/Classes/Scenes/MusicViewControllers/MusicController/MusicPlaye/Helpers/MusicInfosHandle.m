//
//  MusicInfosHandle.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/16.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MusicInfosHandle.h"
#import "NetWorkRequestManager.h"
#import "MusicInfo.h"
@interface MusicInfosHandle()
@property (nonatomic, strong) NSMutableArray * musicInfosArray;//存放所有歌曲信息对象
@end

@implementation MusicInfosHandle
//实现获取单例
singleton_implementaton(MusicInfosHandle)
/**
 *  根据url进行请求，获取所有musicInfo对象
 *
 *  @param urlString  url地址
 *  @param completion 完成之后回调的block
 */
- (void)getMusicInfosWithUrl:(NSString *)urlString completion:(Completion)completion
{
    //进行网络请求
    [NetWorkRequestManager requestType:GET UrlString:urlString Param:nil Successed:^(id data) {
        
        NSError * error = nil;
        //生成存储data的plist文件，所在路径
       NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES) lastObject];
        NSString * fileNamePath = [filePath stringByAppendingPathComponent:@"musicInfos.plist"];
       BOOL flag = [data writeToFile:fileNamePath options:NSDataWritingAtomic error:&error];
        if (flag && !error) {
                NSArray * resultArray = [NSArray arrayWithContentsOfFile:fileNamePath];
            //每次请求数据，要把之前的数据清空掉（特殊情况特殊对待【上拉加载】）
            [self.musicInfosArray removeAllObjects];
            //将数组中的数据生成musicInfo对象，存储到数组中
            for (NSDictionary * dict in resultArray) {
                MusicInfo * music = [MusicInfo new];
                [music setValuesForKeysWithDictionary:dict];
                [self.musicInfosArray addObject:music];
            }
            
        }else{
            NSLog(@"The data is writed failed:%@",error);
        }
        if (completion) {
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                  completion(_musicInfosArray,error);
            });
        }
    } Failed:^(NSError *error) {
        
        completion(nil,error);
    }];
    
    
}
//懒加载实现对数组进行初始化
- (NSMutableArray *)musicInfosArray
{
    if (!_musicInfosArray) {
        _musicInfosArray = [NSMutableArray array];
    }
    return _musicInfosArray;
}
- (NSInteger)numberOfSections
{
    return 1;
}
/**
 *  根据指定section获取对应多少row
 *
 *  @param section 指定的section
 *
 *  @return row行数
 */
- (NSInteger)numberofRowsInSection:(NSInteger)section
{
    return _musicInfosArray.count;
}
/**
 *  返回某个分区section下的某行row对应的musicInfo
 *
 *  @param indexPath indexPath
 */
- (MusicInfo *)musicInfoForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _musicInfosArray[indexPath.row];
}

#pragma mark -- 配置播放页面数据源相关操作
/**
 *  获取上一首
 *
 *  @param index 指定歌曲的下标
 *
 *  @return 歌曲对象
 */
- (MusicInfo *)musicInfoLastWithIndex:(NSInteger*)index
{
    if (*index == 0) {
        *index = _musicInfosArray.count - 1;
    }else{
        (*index)--;
    }
    return _musicInfosArray[*index];
}
/**
 *  获取下一首
 *
 *  @param index 指定歌曲的下标
 *
 *  @return 歌曲对象
 */
- (MusicInfo *)musicInfoNextWithIndex:(NSInteger*)index
{
    if (*index == (_musicInfosArray.count - 1)) {
        *index = 0;
    }else{
        (*index)++;
    }
    return _musicInfosArray[*index];
}
/**
 *  随机一首歌曲
 *
 *  @return 歌曲对象
 */
- (MusicInfo *)musicInfoOfRandom
{
    return _musicInfosArray[arc4random()%_musicInfosArray.count];
}






@end
