//
//  NetWorkRequest.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseRequest.h"

// 成功回调Block
typedef void(^SuccessResponse)(NSDictionary *dic);
// 失败回调Block
typedef void(^FailureResponse)(NSError *error);

@interface NetWorkRequest : BaseRequest

/// 单例
+ (instancetype)shareRequest;

/*请求数据
 @url ：请求数据的url
 @parameterDic ：成功回调的block
 @success ：成功的回调
 @failure ：失败的回调
 */
- (void)requestWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameterDic
       successResponse:(SuccessResponse)success
       failureResponse:(FailureResponse)failure;

/// 登录
- (void)sendDataWithUrl:(NSString *)url
             parameters:(NSDictionary *)parameterDic
        successResponse:(SuccessResponse)success
        failureResponse:(FailureResponse)failure;
/// 注册
- (void)sendDataWithUrl:(NSString *)url
             parameters:(NSDictionary *)parameterDic
                  image:(UIImage *)uploadImage
        successResponse:(SuccessResponse)success
        failureResponse:(FailureResponse)failure;

@end
