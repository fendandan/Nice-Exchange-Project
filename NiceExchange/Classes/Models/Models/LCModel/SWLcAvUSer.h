//
//  SWLcAvUSer.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "AVUser.h"
@class SWCount;
@interface SWLcAvUSer : AVUser<AVSubclassing>

@property (strong) NSString *displayName;
@property (strong) AVFile *userImage;
@property (strong) NSArray *markActivitys;
@property (strong) NSArray *myActivitys;
@property (strong) NSArray *comment;
@property (strong) SWCount *count;

@property(retain) AVRelation *friends;

@end
