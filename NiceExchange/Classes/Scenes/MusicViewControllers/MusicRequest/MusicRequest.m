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



- (void)musicDetailRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    
    [request requestWithUrl:parameterDic[@"urlString"] parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
        
    } failureResponse:^(NSError *error) {
        
        failure(error);
        
    }];
    
}









//轮播请求
- (void)oneScrollRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *requst = [[NetWorkRequest alloc] init];
    [requst requestWithUrl:oneMusicrequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];
    
    
}




- (void)twoScrollRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *requst = [[NetWorkRequest alloc] init];
    [requst requestWithUrl:twoMusicRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];
    
    
}



- (void)threeScrollRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    NetWorkRequest *requst = [[NetWorkRequest alloc] init];
    [requst requestWithUrl:threeMusicRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];
    
}



- (void)fourScrollRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    
    NetWorkRequest *requst = [[NetWorkRequest alloc] init];
    [requst requestWithUrl:fourMusicRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];
    
}




- (void)fiveScrollRequestparameter:(NSDictionary *)parameterDic success:(SuccessResponse)success failure:(FailureResponse)failure
{
    
    NetWorkRequest *requst = [[NetWorkRequest alloc] init];
    [requst requestWithUrl:fiveMusicRequest_Url parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];
    
    
    
}










@end
