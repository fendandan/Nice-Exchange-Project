//
//  MusicModel.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"logo = %@,name = %@", _logo,_name];
}

@end