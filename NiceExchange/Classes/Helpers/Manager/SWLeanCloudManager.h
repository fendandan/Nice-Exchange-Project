//
//  SWLeanCloudManager.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseManager.h"

// 成功回调Block
typedef void(^SuccessRespon)(AVObject *obj, NSArray *arrays);
// 失败回调Block
typedef void(^FailureRespon)(NSError *error);

@interface SWLeanCloudManager : BaseManager

+ (instancetype)shareManager;

/// 保存实例对象到云端
- (void)lcSaveObjectWithAVObject:(AVObject *)object;

/// 批量操作 --- 查询云端表中所有实例对象（请求数据）
- (void)lcSelectObjectsWithClassName:(NSString *)className
                     successRespon:(SuccessRespon)success
                     failureRespon:(FailureRespon)failure;

/// 查询云端实例对象（请求数据）
- (void)lcSelectObjectWithClassName:(NSString *)className
                         objectId:(NSString *)objectId
                  successRespon:(SuccessRespon)success
                  failureRespon:(FailureRespon)failure;

/// 云端实例对象查看计数器(调用方法 用以 累计 查看数)
- (void)lcSetObjectSeeCountWithClassName:(NSString *)className
                     objectId:(NSString *)objectId;
/// 删除云端实例对象
- (void)lcDeleteObjectWithClassName:(NSString *)className
                   objectId:(NSString *)objectId;


/// 增加对象的数组属性（数组容器）
- (void)lcAddArrayWithClassName:(NSString *)className array:(NSArray *)array;

/// 增加对象的数组属性的数组元素
- (void)lcAddObjectToArrayWithClassName:(NSString *)className array:(NSArray *)array;

/// 删除对象的数组属性的数组元素
- (void)lcRemoveObjectForArrayWithClassName:(NSString *)className array:(NSArray *)array;

@end
