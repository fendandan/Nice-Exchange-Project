//
//  SWFocusonViewController.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseViewController.h"


typedef NS_ENUM(NSUInteger , RequestData)
{    ///关注
    RequestDataFoucesRequest,
    ///发起
    RequestDataInitiateRequest,
    ///参与
    RequestDataParticipate
    
    
};
@interface SWFocusonViewController : BaseViewController

@property (nonatomic,strong) SWActivityList *activity;


@property (nonatomic , assign) RequestData RequestData;



@end
