//
//  NetWorkRequest.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest

static NetWorkRequest *request = nil;

// 单例
+ (instancetype)shareRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(request) {
        if (!request) {
            request = [super allocWithZone:zone];
        }
    }
    return request;
}


// GET请求数据
- (void)requestWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameterDic
       successResponse:(SuccessResponse)success
       failureResponse:(FailureResponse)failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}

// 登录
- (void)sendDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameterDic successResponse:(SuccessResponse)success failureResponse:(FailureResponse)failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

// 注册
- (void)sendDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameterDic image:(UIImage *)uploadImage successResponse:(SuccessResponse)success failureResponse:(FailureResponse)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameterDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(uploadImage, 0.5) name:@"avatar" fileName:@"avatar.jpg" mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
