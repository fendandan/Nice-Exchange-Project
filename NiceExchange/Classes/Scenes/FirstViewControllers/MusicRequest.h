//
//  MusicRequest.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicRequest : NSObject


- (void)musicRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure;



@end
