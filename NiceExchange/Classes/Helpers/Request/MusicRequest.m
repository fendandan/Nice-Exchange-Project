//
//  MusicRequest.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "MusicRequest.h"

@implementation MusicRequest


- (void)musicRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *requst = [[NetWorkRequest alloc] init];
    [requst requestWithUrl:MusicRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];
}










@end
