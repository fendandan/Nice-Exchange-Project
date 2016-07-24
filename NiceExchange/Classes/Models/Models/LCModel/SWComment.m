//
//  SWComment.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/23.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWComment.h"

@implementation SWComment

@dynamic secondComment;

@dynamic commentContent;
@dynamic forActivity;
@dynamic commentCount;
@dynamic goodCount;
@dynamic lowCount;
@dynamic commentBy;

@dynamic forComment;



+ (NSString *)parseClassName {
    return @"Comment";
}

@end
