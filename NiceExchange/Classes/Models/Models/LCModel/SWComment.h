//
//  SWComment.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/23.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaseLCModel.h"

@interface SWComment : SWBaseLCModel

@property (strong) AVRelation *secondComment;

@property (copy) NSString *commentContent;
@property (strong) SWActivityList *forActivity;
@property (strong) SWComment *forComment;
@property (strong) NSNumber *commentCount;
@property (strong) NSNumber *goodCount;
@property (strong) NSNumber *lowCount;

@property (strong) SWLcAvUSer *commentBy;


@end
