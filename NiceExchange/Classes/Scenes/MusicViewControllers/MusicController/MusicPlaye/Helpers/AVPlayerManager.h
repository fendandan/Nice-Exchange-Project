//
//  AVPlayerManager.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/17.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"
//声明协议
@protocol AVPlayerManagerDelegate <NSObject>
//当avplayer播放时间不断改变时，让代理执行该方法，将当前的时间传过去
- (void)changeTime:(CGFloat)time;

//当一首歌曲播放完成时，让代理执行该方法
- (void)playDidFinished;

@end


typedef NS_ENUM(NSUInteger, AVPlayerManagerStatus) {
    isPlaying, //正在播放
    isPaused,  //暂停播放
    isStopped, //停止播放
};

@interface AVPlayerManager : NSObject
//声明单例
singleton_interface(AVPlayerManager);
@property (nonatomic, weak) id <AVPlayerManagerDelegate> delegate; //代理
@property (nonatomic, assign)AVPlayerManagerStatus status;  //用来表示当前播放器的播放状态
@property (nonatomic, assign) CGFloat volume; //音量

@property (nonatomic, strong)UIViewController * VC;//用来持有当前正在播放歌曲的视图控制器对象



/**
 *  设置要播放的音乐
 *
 *  @param urlString 音乐地址
 */
- (void)playWithUrl:(NSString *)urlString;
/**
 *  播放音乐
 */
- (void)play;
/**
 *  暂停
 */
- (void)pasue;
/**
 *  根据时间播放歌曲，跳到指定时间点播放歌曲
 *
 *  @param time 指定的时间
 */
- (void)seekToTime:(CGFloat)time;








@end
