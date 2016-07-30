//
//  SWDraftModel.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/30.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWDraftModel.h"

@implementation SWDraftModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID  = (NSInteger)value;
    }
    
    
    
}

@end
