//
//  SWActivityList.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaseLCModel.h"
@class SWLcAvUSer;
@interface SWActivityList : SWBaseLCModel

@property (copy) NSString *title;
@property (copy) NSString *content;
@property (strong) AVFile *titleImage;
@property (copy) NSNumber *markC;
@property (strong) SWLcAvUSer *createBy;
@property (strong) AVRelation *commentRelation;

@property (copy) NSString *label;
@property (copy) NSString *rule;
@property (strong) AVGeoPoint *point;
@property (copy) NSString *subhead;

@end
