//
//  NetWorkRequestManager.h
//  DouBanProject
//
//  Created by 王佩 on 16/5/9.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef NS_ENUM(NSInteger,requestType){
    GET,
    POST,
    DELETE,
    PUT
};

typedef void(^successedBlock)(id data);
typedef void(^failedBlock)(NSError * error);

@interface NetWorkRequestManager : NSObject


/**
 *  网络请求
 *
 *  @param type           请求方式
 *  @param urlString      URL
 *  @param param          请求参数
 *  @param successedBlock 请求成功执行的block
 *  @param failedBlock    请求失败执行的block
 */
+ (void)requestType:(requestType)type UrlString:(NSString *)urlString Param:(NSDictionary *)param Successed:(successedBlock)successedBlock Failed:(failedBlock)failedBlock;

singleton_interface(NetWorkRequestManager);


@end
