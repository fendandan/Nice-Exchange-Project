//
//  SWDraftModel.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/30.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseModel.h"

@interface SWDraftModel : BaseModel

@property(nonatomic,assign)NSInteger ID;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *content;

@property(nonatomic,strong)NSString *label;

@property(nonatomic,strong)NSString *rule;

@property(nonatomic,assign)double latitude;

@property(nonatomic,assign)double longitude;

@property(nonatomic,strong)NSString *subhead;

@property(nonatomic,strong)NSString *time;

@end
