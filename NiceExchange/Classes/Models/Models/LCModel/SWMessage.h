//
//  SWMessage.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/25.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaseLCModel.h"

@interface SWMessage : SWBaseLCModel

@property (strong) SWLcAvUSer *subOne;
@property (strong) SWLcAvUSer *subTwo;
@property (strong) AVRelation *messageRelation;
@property (strong) SWLcAvUSer *from;
@property (strong) SWLcAvUSer *to;
@property (copy) NSString *message;
@property (assign) BOOL *isReaded;

@end
