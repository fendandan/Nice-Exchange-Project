//
//  AVPlayerManager.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/17.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "AVPlayerManager.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerManager ()
@property (nonatomic, strong)AVPlayer * avPlayer;  //播放器
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation AVPlayerManager
//实现单例
singleton_implementaton(AVPlayerManager)

- (instancetype)init{
    if (self = [super init]) {
        self.status = isStopped;//停止状态
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
      //创建定时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer invalidate];//停止，这个_timer对象会被彻底销毁
        _timer = nil;
//        暂停定时器
        _timer.fireDate = [NSDate distantFuture];
        
    }
    return self;
}
- (void)timerAction:(NSTimer *)timer
{
    if ([_delegate respondsToSelector:@selector(changeTime:)]) {
//        value / timescale
        CGFloat currentTime = _avPlayer.currentItem.currentTime.value / _avPlayer.currentTime.timescale;
        [_delegate changeTime:currentTime];
    }
}


#pragma mark -- 私有方法
//播放完毕时，触发通知中的方法
- (void)playerItemDidPlayFinished
{
    if ([_delegate respondsToSelector:@selector(playDidFinished)]) {
        [_delegate playDidFinished];
    }
}


/**
 *  设置要播放的音乐
 *
 *  @param urlString 音乐地址
 */
- (void)playWithUrl:(NSString *)urlString
{
    //创建playerItem
    AVPlayerItem * item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    if (!_avPlayer) {
        _avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
        //使用KVO实现对_avPlayer的status监测
        [_avPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
    }else{
        //替换当前播放的歌曲
        [_avPlayer replaceCurrentItemWithPlayerItem:item];
    }
    
    [self play];
    
}
/**
 *  播放音乐
 */
- (void)play
{
    [_avPlayer play];
    _timer.fireDate = [NSDate distantPast];
    _status = isPlaying;
}
/**
 *  暂停
 */
- (void)pasue
{
    [_avPlayer pause];
    _timer.fireDate = [NSDate distantFuture];
    _status = isPaused;
}
/**
 *  根据时间播放歌曲，跳到指定时间点播放歌曲
 *
 *  @param time 指定的时间
 */
- (void)seekToTime:(CGFloat)time
{
    //value = seconds * timescale
    [_avPlayer seekToTime:CMTimeMake(time * _avPlayer.currentItem.currentTime.timescale, _avPlayer.currentTime.timescale)];
}


#pragma mark-- 实现KVO监测方法
//当_avPlayer的status发生变化时执行
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
     AVPlayerStatus  status = [change[@"new"] integerValue];
    switch (status) {
        case AVPlayerStatusReadyToPlay:
            _status = isPlaying;
            break;
        case AVPlayerStatusFailed:
            _status = isPaused;
            break;
        default:
            _status = isStopped;
            break;
    }
    
    
}

#pragma mark -- 重写setter方法，实现设置音量
- (void)setVolume:(CGFloat)volume
{
    _volume = volume;
    _avPlayer.volume = _volume;
}








@end
