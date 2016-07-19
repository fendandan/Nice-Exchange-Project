//
//  SWActivityList.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWActivityList.h"

@implementation SWActivityList

@dynamic title;
@dynamic content;
@dynamic imageUrl;
@dynamic mark;
@dynamic createBy;
@dynamic talk;

+ (NSString *)parseClassName {
    return @"ActivityList";
}

@end
