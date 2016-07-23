//
//  SWFollow.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/21.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaseLCModel.h"

@interface SWFollow : SWBaseLCModel

@property (strong) SWLcAvUSer *from;
@property (strong) SWLcAvUSer *to;
@property (strong) NSDate *date;

@end
