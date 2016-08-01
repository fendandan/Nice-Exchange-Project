//
//  NSString+timeFormatter.h
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/17.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (timeFormatter)
//"150" --> "02:30"
+ (NSString *)getStringFormatByTime:(CGFloat)seconds;
//"02:30" --> "150"

- (CGFloat)getSecondsFormatByString;






@end
