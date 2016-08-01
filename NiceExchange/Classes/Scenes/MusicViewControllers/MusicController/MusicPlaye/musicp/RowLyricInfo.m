//
//  RowLyricInfo.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/18.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "RowLyricInfo.h"

@implementation RowLyricInfo
//自定义初始化实例方法
- (instancetype)initWithRowLyricStr:(NSString *)rowLyric time:(CGFloat)time
{
    if (self = [super init]) {
        _rowLyricStr = rowLyric;
        _time = time;
    }
    return self;
}
//遍历构造器
+ (instancetype)rowLyricWithRowLyricStr:(NSString *)rowLyric time:(CGFloat)time
{
    return [[RowLyricInfo alloc] initWithRowLyricStr:rowLyric time:time];
}

@end
