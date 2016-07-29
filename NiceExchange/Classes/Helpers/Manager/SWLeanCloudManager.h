//
//  SWLeanCloudManager.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseManager.h"

@class SWActivityList;
@class SWComment;

// 成功回调Block
typedef void(^SuccessRespon)(AVObject *obj, NSArray *arrays);
// 失败回调Block
typedef void(^FailureRespon)(NSError *error);

/// 完成后回调
typedef void(^UIFBlock)(NSArray *mArray);

@interface SWLeanCloudManager : BaseManager

+ (instancetype)shareManager;

#pragma mark ---- LeanCloud数据存储管理



/// 保存实例对象到云端
- (void)lcSaveObjectWithAVObject:(AVObject *)object;

/// （根据活动）关注其发布者（block参数为空）
- (void)lcToFollowOtherUserWithActivityList:(SWActivityList *)activity completion:(UIFBlock)completion;
/// （根据活动）取消关注其发布者（block参数为空）
- (void)lcToCancelFollowOtherUserWithActivityList:(SWActivityList *)activity completion:(UIFBlock)completion;

/// 控制方法可执行状态的bool
@property (assign, nonatomic) BOOL shareManagerB;
/// 控制方法可执行状态的bool，c
@property (assign, nonatomic) BOOL shareManagerBm;

/// 添加文字评论方法（一级评论）（block参数为空）
- (void)lcToCommentingWithActivityList:(SWActivityList *)activity commentString:(NSString *)commentString completion:(UIFBlock)completion;
/// 查询评论方法（一级评论）（block参数为查询结果-可变数组）
- (void)lcSelectCommentWithActivityList:(SWActivityList *)activity conditions:(NSString *)conditions completion:(UIFBlock)completion;
/// 添加文字评论方法（二级评论）（block参数为空）
- (void)lcToCommentingWithComment:(SWComment *)fristComment commentString:(NSString *)commentString completion:(UIFBlock)completion;
/// 查询评论方法（二级评论）（block参数为查询结果-可变数组）
- (void)lcSelectCommentWithComment:(SWComment *)fristComment completion:(UIFBlock)completion;
/// 收藏活动的方法（block参数为空）
- (void)lcToMarkActivityWithActivityList:(SWActivityList *)activity completion:(UIFBlock)completion;
/// 取消收藏活动的方法（block参数为空）
- (void)lcToCancelMarkActivityWithActivityList:(SWActivityList *)activity completion:(UIFBlock)completion;

///// 批量操作 --- 查询云端表中所有实例对象（请求数据）
//- (void)lcSelectObjectsWithClassName:(NSString *)className
//                     successRespon:(SuccessRespon)success
//                     failureRespon:(FailureRespon)failure;
//
///// 查询云端实例对象（请求数据）
//- (void)lcSelectObjectWithClassName:(NSString *)className
//                         objectId:(NSString *)objectId
//                  successRespon:(SuccessRespon)success
//                  failureRespon:(FailureRespon)failure;
//
///// 云端实例对象查看计数器(调用方法 用以 累计 查看数)
//- (void)lcSetObjectSeeCountWithClassName:(NSString *)className
//                     objectId:(NSString *)objectId;
///// 删除云端实例对象
//- (void)lcDeleteObjectWithClassName:(NSString *)className
//                   objectId:(NSString *)objectId;
//
//
///// 增加对象的数组属性（数组容器）
//- (void)lcAddArrayWithClassName:(NSString *)className array:(NSArray *)array;
//
///// 增加对象的数组属性的数组元素
//- (void)lcAddObjectToArrayWithClassName:(NSString *)className array:(NSArray *)array;
//
///// 删除对象的数组属性的数组元素
//- (void)lcRemoveObjectForArrayWithClassName:(NSString *)className array:(NSArray *)array;

@end
