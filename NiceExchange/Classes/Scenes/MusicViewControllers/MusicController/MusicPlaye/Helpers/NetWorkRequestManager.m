//
//  NetWorkRequestManager.m
//  DouBanProject
//
//  Created by 王佩 on 16/5/9.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager


+ (void)requestType:(requestType)type UrlString:(NSString *)urlString Param:(NSDictionary *)param Successed:(successedBlock)successedBlock Failed:(failedBlock)failedBlock
{
    switch (type) {
        case GET:
        {
           NetWorkRequestManager * manager = [NetWorkRequestManager sharedNetWorkRequestManager];
            [manager getWithUrlString:urlString param:param successed:successedBlock failed:failedBlock];
            break;
        }
        case POST:
            
            break;
        case DELETE:
            
            break;
        case PUT:
            
            break;
            
        default:
            break;
    }
}

- (void)getWithUrlString:(NSString *)urlString param:(NSDictionary *)dic successed:(successedBlock)success failed:(failedBlock)fail
{
    //使用NSURLSession
    //1.获取session对象
    NSURLSession * session = [NSURLSession sharedSession];
    //2.拼接字符串
    NSMutableString * urlStr = [NSMutableString stringWithString:urlString];
    if (dic) {
        
        [urlStr appendString:@"?"];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [urlStr appendString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
        }];
        
        [urlStr substringToIndex:urlStr.length-2];
    }
    //3.转码
    
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:urlStr];
   NSString * url = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:set];
    //4.设置request对象
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //设置请求方式
    request.HTTPMethod = @"GET";
    //链接并发送请求
   NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (data && !error) {
            success(data);
        }else{
            if (!data) {
                NSLog(@"请求数据为空!!");
            }
            if (error) {
                fail(error);
            }
        }
    }];
    [task resume];
    
}

//
singleton_implementaton(NetWorkRequestManager);




@end
