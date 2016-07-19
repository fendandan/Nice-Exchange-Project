//
//  SWActivityList.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWBaseLCModel.h"

@interface SWActivityList : SWBaseLCModel

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *mark;
@property (copy, nonatomic) AVUser *createBy;
@property (copy, nonatomic) NSArray *talk;

@end
