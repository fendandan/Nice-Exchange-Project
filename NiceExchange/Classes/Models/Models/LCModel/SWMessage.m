//
//  SWMessage.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/25.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWMessage.h"

@implementation SWMessage

@dynamic subOne;
@dynamic subTwo;
@dynamic messageRelation;
@dynamic message;
@dynamic from;
@dynamic to;
@dynamic isReaded;

+ (NSString *)parseClassName {
    return @"Message";
}
@end
