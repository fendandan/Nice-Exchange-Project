//
//  RowLyricInfo.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/18.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RowLyricInfo : NSObject

@property (nonatomic, assign) CGFloat time; //时间   单位 s
@property (nonatomic, strong) NSString * rowLyricStr;  //单行歌词
//自定义初始化实例方法
- (instancetype)initWithRowLyricStr:(NSString *)rowLyric time:(CGFloat)time;
//遍历构造器
+ (instancetype)rowLyricWithRowLyricStr:(NSString *)rowLyric time:(CGFloat)time;

@end
