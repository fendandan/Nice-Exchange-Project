//
//  SWCount.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/21.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaseLCModel.h"

@interface SWCount : SWBaseLCModel

@property (strong) NSNumber *activityC;
@property (strong) NSNumber *followedC;
@property (strong) NSNumber *commentC;
@property (strong) NSNumber *followC;
@property (strong) NSNumber *markC;
@property (strong) SWLcAvUSer *createBy;

@end
