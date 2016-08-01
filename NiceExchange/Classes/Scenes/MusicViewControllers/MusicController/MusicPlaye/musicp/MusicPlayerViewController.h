//
//  MusicPlayViewController.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/16.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicInfo.h"
@interface MusicPlayerViewController : UIViewController

@property (nonatomic, strong) MusicInfo * music; //用来接收上一个页面传过来的值
@property (nonatomic, assign) NSInteger index;//接收所要播放的歌曲对应的下标






@end
