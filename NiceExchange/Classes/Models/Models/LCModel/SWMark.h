//
//  SWMark.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/21.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaseLCModel.h"

@interface SWMark : SWBaseLCModel

@property (strong) SWLcAvUSer *markBy;
@property (strong) SWLcAvUSer *markTo;
@property (strong) SWActivityList *activity;
@property (strong) NSDate *date;

@end
