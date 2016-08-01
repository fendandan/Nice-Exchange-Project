//
//  MusicPlayViewController.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/16.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "AVPlayerManager.h"

#import "NSString+timeFormatter.h"
#import "MusicInfosHandle.h"
#import "LyricInfosHandle.h"
#import "LyricCell.h"
//获取音乐播放单例对象
#define kAVPlayerManager [AVPlayerManager sharedAVPlayerManager]
//获取音乐信息单例对象
#define kMusicInfosHandle [MusicInfosHandle sharedMusicInfosHandle]
//获取歌词信息单例对象
#define kLyricInfosHandle [LyricInfosHandle sharedLyricInfosHandle]


//表示的是当前循环播放的模式
typedef NS_ENUM(NSUInteger, LoopMode) {
    SingleMode,    //单曲循环播放
    RandomMode,    //随机循环播放
    OrderMode,     //顺序循环播放
};
@interface MusicPlayerViewController ()<AVPlayerManagerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    LoopMode _loopMode;//用来表示当前循环播放的模式
    BOOL _isSeek;
}
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView;   //音乐图片
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;  //进度条
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;    //模糊视图
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;   //页面消失button
@property (weak, nonatomic) IBOutlet UITableView *tableView;    //歌词列表
@property (weak, nonatomic) IBOutlet UILabel *currentPlayTimeLabel; //当前播放时间标签
@property (weak, nonatomic) IBOutlet UILabel *remainTimeLabel;  //剩余时间标签
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;    //歌名标签
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;  //歌手标签
@property (weak, nonatomic) IBOutlet UIButton *rewindButton;    //上一首
@property (weak, nonatomic) IBOutlet UIButton *forwindButton; //下一首
@property (weak, nonatomic) IBOutlet UIButton *playButton;  //播放按钮
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;    //音量滑动条
@property (weak, nonatomic) IBOutlet UIButton *singleLoopButton;    //单曲循环按钮
@property (weak, nonatomic) IBOutlet UIButton *loopButton;  //顺序循环按钮
@property (weak, nonatomic) IBOutlet UIButton *randomButton;  //随机按钮



@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //将musicImageView设置为圆角
    _musicImageView.layer.cornerRadius = ([UIScreen mainScreen].bounds.size.width - 100) / 2;
    _musicImageView.layer.masksToBounds = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_progressSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    //设置显示歌词的tableView代理
    _tableView.delegate = self;
    _tableView.dataSource = self;

    //设置view上的所有子视图
    [self playAndSetUpSubViews];

    //设置代理
    kAVPlayerManager.delegate = self;

}
#pragma mark -  私有方法
/**
 *    设置view上的所有子视图
 */
- (void)playAndSetUpSubViews
{
    //播放歌曲
    [kAVPlayerManager playWithUrl:_music.mp3Url];
    //改变播放按钮的状态
    [_playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    //设置歌曲的相关信息
    _nameLabel.text = _music.name;
    _singerLabel.text = _music.singer;
    [_musicImageView setImageWithURL:[NSURL URLWithString:_music.picUrl] placeholderImage:[UIImage imageNamed:@"songzhongji"]];
    [_blurImageView setImageWithURL:[NSURL URLWithString:_music.blurPicUrl]];
    //设置timeSlider的 min 和 max
    _progressSlider.minimumValue = 0.0;
    _progressSlider.maximumValue = _music.duration / 1000.0;
    _progressSlider.value = 0.0;
    //设置volumeSlider的 min 和 max
    _volumeSlider.minimumValue = 0.0;
    _volumeSlider.maximumValue = 1.0;
    _volumeSlider.value = 0.5;
    //设置当前时间label 和 剩余时间label
    _currentPlayTimeLabel.text = @"00:00";
    _remainTimeLabel.text = [NSString getStringFormatByTime:_music.duration/1000.0];
#pragma mark --- 显示歌词部分
    NSLog(@"%@",_music.lyric);
    //解析歌词
   NSArray * resultArray = [kLyricInfosHandle lyricsWithLyricString:_music.lyric];
    //刷新表视图
    [self.tableView reloadData];
    //回到tableView顶部
//    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
//点击左上角button,界面dismiss
- (IBAction)ClickDismissButton:(UIButton *)sender {

    //返回上个页面
    [self dismissViewControllerAnimated:YES completion:nil];
}
//时间进度条改变,跳到指定时间播放音乐
- (IBAction)progressChanged:(UISlider *)sender {

    _isSeek = YES;
}

- (IBAction)progressTouchUpInside:(id)sender {
    [kAVPlayerManager seekToTime:_progressSlider.value];
    _isSeek = NO;

}
//上一首
- (IBAction)lastMusic:(UIButton *)sender {
   _music = [kMusicInfosHandle musicInfoLastWithIndex:&_index];
    [self playAndSetUpSubViews];
}
//下一首
- (IBAction)nextMusic:(UIButton *)sender {
    
    _music = [kMusicInfosHandle musicInfoNextWithIndex:&_index];
    [self playAndSetUpSubViews];
    
}
//播放 or 暂停
- (IBAction)playOrPause:(UIButton *)sender {
    if (kAVPlayerManager.status == isPaused) {
        [kAVPlayerManager play];
        [_playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }else if(kAVPlayerManager.status == isPlaying){
        [kAVPlayerManager pasue];
        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}
//设置音量
- (IBAction)changeVolumeValue:(UISlider *)sender {
    kAVPlayerManager.volume = sender.value;
}

- (IBAction)singleLoop:(UIButton *)sender {
    [_singleLoopButton setImage:[UIImage imageNamed:@"singleloop-s.png"] forState:UIControlStateNormal];
    [_loopButton setImage:[UIImage imageNamed:@"loop"] forState:UIControlStateNormal];
    [_randomButton setImage:[UIImage imageNamed:@"shuffle"] forState:UIControlStateNormal];
    //设置循环播放的模式
    _loopMode = SingleMode;
    
}

- (IBAction)orderLoop:(UIButton *)sender {
    [_singleLoopButton setImage:[UIImage imageNamed:@"singleloop"] forState:UIControlStateNormal];
    [_loopButton setImage:[UIImage imageNamed:@"loop-s"] forState:UIControlStateNormal];
    [_randomButton setImage:[UIImage imageNamed:@"shuffle"] forState:UIControlStateNormal];
    //设置循环播放的模式
    _loopMode = OrderMode;
}

- (IBAction)shuffleLoop:(UIButton *)sender {
    [_singleLoopButton setImage:[UIImage imageNamed:@"singleloop"] forState:UIControlStateNormal];
    [_loopButton setImage:[UIImage imageNamed:@"loop"] forState:UIControlStateNormal];
    [_randomButton setImage:[UIImage imageNamed:@"shuffle-s"] forState:UIControlStateNormal];
    //设置循环播放的模式
    _loopMode = RandomMode;

}

#pragma mark - AVPlayerManager Delegate
//实现当一首歌曲播放结束时，代理会执行这个方法
- (void)playDidFinished
{
    //判断以什么循环模式获取接下来要播放的歌曲
    [self getMusicByLoopMode];
}
- (void)getMusicByLoopMode
{
    switch (_loopMode) {
        case SingleMode:
            [self playAndSetUpSubViews];
            break;
        case RandomMode:
            _music = [kMusicInfosHandle musicInfoOfRandom];
            [self playAndSetUpSubViews];
            break;
        case OrderMode:
            _music = [kMusicInfosHandle musicInfoNextWithIndex:&_index];
            [self playAndSetUpSubViews];
            break;
        default:
            break;
    }
}
//根据代理-协议传过来的值，给时间Slider不断改变
- (void)changeTime:(CGFloat)time
{
    if (!_isSeek) {
    
        _progressSlider.value = time;
    }
    _currentPlayTimeLabel.text = [NSString getStringFormatByTime:time];
    _remainTimeLabel.text = [NSString getStringFormatByTime:_music.duration/1000.0 - time];
    //音乐图片旋转
    
    [UIView animateWithDuration:0.1 animations:^{
        _musicImageView.transform = CGAffineTransformRotate(_musicImageView.transform, 0.05);
    }];
#pragma mark -- 显示当前播放到的歌词
    [self showPlayingLyric:time];
}
- (void)showPlayingLyric:(CGFloat)time
{
    NSInteger index = [kLyricInfosHandle indexForRowByTime:time];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
   LyricCell * showCell = [_tableView cellForRowAtIndexPath:indexPath];
    showCell.lyricLabel.textColor = [UIColor redColor];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    //清除没有播放到的cell上文字的颜色
    for (int i = 0; i < [kLyricInfosHandle numberofRowsInSection:0]; i++) {
        if (i != index) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            LyricCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
            cell.lyricLabel.textColor = [UIColor whiteColor];
            
        }
    }
}


#pragma mark --- 实现显示歌词tableView的代理协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [kLyricInfosHandle numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [kLyricInfosHandle numberofRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LyricCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LyricCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    RowLyricInfo * lyric = [kLyricInfosHandle rowLyricInfoForRowAtIndexPath:indexPath];
    cell.lyricLabel.text = lyric.rowLyricStr;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LyricCell heightForCellWithLyric:[[kLyricInfosHandle rowLyricInfoForRowAtIndexPath:indexPath] rowLyricStr]];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
