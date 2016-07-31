//
//  SWMark.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/21.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWMark.h"

@implementation SWMark

@dynamic markBy;
@dynamic markTo;
@dynamic activity;
@dynamic date;

+ (NSString *)parseClassName {
    return @"Mark";
}

@end
