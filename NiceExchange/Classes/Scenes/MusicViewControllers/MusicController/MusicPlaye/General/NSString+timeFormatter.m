//
//  NSString+timeFormatter.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/17.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "NSString+timeFormatter.h"

@implementation NSString (timeFormatter)
//"150" --> "02:30"
+ (NSString *)getStringFormatByTime:(CGFloat)seconds;
{
    // seconds / 60   分钟
    // seconds % 60   秒数
    return [NSString stringWithFormat:@"%02ld:%02ld",(NSInteger)seconds/60,(NSInteger)seconds%60];
}
//"02:30" --> "150"

- (CGFloat)getSecondsFormatByString
{
   // "02:30"    ["02","30"]
  NSArray * tempArray = [self componentsSeparatedByString:@":"];
    return [[tempArray firstObject] integerValue]*60.0 + [[tempArray lastObject] integerValue];
}
@end





