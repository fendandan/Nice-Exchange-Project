//
//  SWLcAvUSer.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWLcAvUSer.h"

@implementation SWLcAvUSer

@dynamic displayName;
@dynamic userImage;
@dynamic markActivitys;
@dynamic myActivitys;
@dynamic comment;
@dynamic count;

@dynamic friends;

+ (NSString *)parseClassName {
    return @"_User";
}

@end
