//
//  SWLeanCloudManager.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/15.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWLeanCloudManager.h"

static SWLeanCloudManager *manager = nil;

@implementation SWLeanCloudManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SWLeanCloudManager alloc] init];
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(manager) {
        if (!manager) {
            manager = [super allocWithZone:zone];
            
        }
    }
    return manager;
}


#pragma mark ---- LeanCloud数据存储管理


// 保存实例对象到云端
- (void)lcSaveObjectWithAVObject:(AVObject *)object
{
    [object saveInBackground];// 保存到云端
}

// 批量查询云端实例对象
- (void)lcSelectObjectsWithClassName:(NSString *)className
                     successRespon:(SuccessRespon)success
                     failureRespon:(FailureRespon)failure
{
    AVQuery *query = [AVQuery queryWithClassName:className];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            NSArray<AVObject *> *todos = objects;
            success(nil, todos); // 传值
            
            /// 批量更新
            [AVObject saveAllInBackground:todos block:^(BOOL succeeded, NSError *error) {
                if (error) {
                    // 网络错误
                    NSLog(@"网络错误");
                } else {
                    // 保存成功
                    NSLog(@"保存成功");
                }
            }];
            
        }else {
            failure(error);
        }
        
//        for (AVObject *todo in todos) {
//            todo[@"status"] = @1;
//        }
        
        
    }];
}

// 查询云端实例对象
- (void)lcSelectObjectWithClassName:(NSString *)className
                         objectId:(NSString *)objectId
                  successRespon:(SuccessRespon)success
                  failureRespon:(FailureRespon)failure {
    // 根据Id查询实例对象的数据
    AVQuery *query = [AVQuery queryWithClassName:className];
    [query getObjectInBackgroundWithId:objectId block:^(AVObject *object, NSError *error) {
        // object 就是 id 为 "objectId" 的 Todo 对象实例
        if (!error) {
            success(object,nil);
        }else {
            failure(error);
        }
    }];
}

// 对象查看计数器
- (void)lcSetObjectSeeCountWithClassName:(NSString *)className
                              objectId:(NSString *)objectId
{
    AVObject *theTodo = [AVObject objectWithClassName:className objectId:objectId];
//    // 初始
//    [theTodo setObject:[NSNumber numberWithInt:0] forKey:@"views"]; //初始值为 0
    [theTodo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        // 原子增加查看的次数
        [theTodo incrementKey:@"views"];
        // 保存时自动取回云端最新数据
        theTodo.fetchWhenSave = true;
        
        [theTodo saveInBackground];
        
//        // 也可以使用 incrementKey:byAmount: 来给 Number 类型字段累加一个特定数值。
//        [theTodo incrementKey:@"views" byAmount:@(5)];
//        [theTodo saveInBackground];
//        // 因为使用了 fetchWhenSave 选项，saveInBackground 调用之后，如果成功的话，对象的计数器字段是当前系统最新值。
    }];
}

// 删除云端实例对象
- (void)lcDeleteObjectWithClassName:(NSString *)className
                   objectId:(NSString *)objectId
{
    AVObject *theTodo = [AVObject objectWithClassName:className objectId:objectId];
    [theTodo deleteInBackground];
}

// 增加对象的数组属性（数组容器）
- (void)lcAddArrayWithClassName:(NSString *)className array:(NSArray *)array {
    
    // addUniqueObject:forKey:
    // addUniqueObjectsFromArray:forKey:
    // 如果不确定某个对象是否已包含在数组字段中，可以使用此操作来添加。对象的插入位置是随机的。
    
    AVObject *todo = [AVObject objectWithClassName:className];
    [todo addUniqueObjectsFromArray:array forKey:@"array"];
    [todo saveInBackground];
}
// 增加对象的数组属性的数组元素
- (void)lcAddObjectToArrayWithClassName:(NSString *)className array:(NSArray *)array {
    // addObject:forKey:
    // addObjectsFromArray:forKey:
    // 将指定对象附加到数组末尾。
    AVObject *todo = [AVObject objectWithClassName:className];
    [todo addObjectsFromArray:array forKey:@"array"];
    
    [todo saveInBackground];
}
// 删除对象的数组属性的数组元素
- (void)lcRemoveObjectForArrayWithClassName:(NSString *)className array:(NSArray *)array {
    // removeObject:forKey:
    // removeObjectsInArray:forKey:
    // 从数组字段中删除指定对象的所有实例。
    AVObject *todo = [AVObject objectWithClassName:className];
    [todo removeObjectsInArray:array forKey:@"array"];
    
    [todo saveInBackground];
}


- (void)lcToFollowOtherUserWithActivityList:(SWActivityList *)activity completion:(UIFBlock)completion {
    if (_shareManagerB) {
        return;
    }
    _shareManagerB = YES;
    SWLog(@"activity %@",activity);
    AVUser *otherUser = activity.createBy;
    SWLog(@"otherUser %@",otherUser);
    
    // create an entry in the Follow table
    AVObject *follow = [AVObject objectWithClassName:@"Follow"];
    [follow setObject:[AVUser currentUser]  forKey:@"from"];
    [follow setObject:otherUser forKey:@"to"];
    [follow setObject:[NSDate date] forKey:@"date"];
    [follow saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            // 更新关注计数
            AVQuery *cQ = [AVQuery queryWithClassName:@"Count"];
            [cQ whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
            [cQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                SWCount *count = objects[0];
                [count incrementKey:@"followC"];
                count.fetchWhenSave = true;
                [count saveInBackground];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil);  // 刷新操作
                });
            }];
        }
    }];
}

- (void)lcToCancelFollowOtherUserWithActivityList:(SWActivityList *)activity completion:(UIFBlock)completion {
    
    if (_shareManagerB) {
        return;
    }
    _shareManagerB = YES;
    SWLog(@"activity %@",activity);
    AVUser *otherUser = activity.createBy;
    SWLog(@"otherUser %@",otherUser);
    
    // create an entry in the Follow table
    AVQuery *fromQuery = [AVQuery queryWithClassName:@"Follow"];
    [fromQuery whereKey:@"from" equalTo:[AVUser currentUser]];
    AVQuery *toQuery = [AVQuery queryWithClassName:@"Follow"];
    [toQuery whereKey:@"to" equalTo:otherUser];
    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:fromQuery,toQuery,nil]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        //
        AVObject *follow = results[0];
        [follow deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            SWLog(@" error %@",error);
            
            if (succeeded) {
                // 更新关注计数
                AVQuery *cQ = [AVQuery queryWithClassName:@"Count"];
                [cQ whereKey:@"createBy" equalTo:[SWLcAvUSer currentUser]];
                [cQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    SWCount *count = objects[0];
                    [count incrementKey:@"followC" byAmount:@(-1)];
                    count.fetchWhenSave = true;
                    [count saveInBackground];
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completion(nil);  // 刷新操作
                    
                });
            }
            
        }];
    }];
    
}


- (void)lcToCommentingWithActivityList:(SWActivityList *)activity commentString:(NSString *)commentString completion:(UIFBlock)completion {
    
    if (_shareManagerBc) {
        return;
    }
    _shareManagerBc = YES;
    
    SWComment *comment = [SWComment object];
    comment.commentContent = commentString;
    comment.forActivity = activity;
    comment.commentCount = @0;
    comment.goodCount = @0;
    comment.lowCount = @0;
    comment.commentBy = [SWLcAvUSer currentUser];
    
    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        SWLog( @"%@",error);
        if (succeeded) {
            [activity.commentRelation addObject:comment];
            [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    
                    completion(nil);  // 刷新操作
                    
                }
            }];
        }
    }];
    
}
- (void)lcSelectCommentWithActivityList:(SWActivityList *)activity completion:(UIFBlock)completion {
    
    if (_shareManagerBc) {
        return;
    }
    _shareManagerBc = YES;
    
    // 查
    // create a relation based on the authors key
    AVRelation *relation = [activity relationForKey:@"commentRelation"];
    
    // generate a query based on that relation
    AVQuery *query = [relation query];
    
    // now execute the query
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (SWComment *c in objects) {
            SWLog(@"%@",c);
            [mArray addObject:c];
        }
        
        completion(mArray); // 传值 刷新
        
    }];
    
}
- (void)lcToCommentingWithComment:(SWComment *)fristComment commentString:(NSString *)commentString completion:(UIFBlock)completion {
    
    if (_shareManagerBc) {
        return;
    }
    _shareManagerBc = YES;
    
    SWComment *comment = [SWComment object];
    comment.commentContent = commentString;
    comment.forComment = fristComment;
//    comment.commentCount = @0;
//    comment.goodCount = @0;
//    comment.lowCount = @0;
    comment.commentBy = [SWLcAvUSer currentUser];
    
    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        SWLog( @" error %@",error);
        if (succeeded) {
            [fristComment.secondComment addObject:comment];
            [fristComment incrementKey:@"commentCount"]; // 计数
            [fristComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                completion(nil); // 刷新
                
            }];
        }
    }];
}
- (void)lcSelectCommentWithComment:(SWComment *)fristComment completion:(UIFBlock)completion {
    if (_shareManagerBc) {
        return;
    }
    _shareManagerBc = YES;
    
    // 查
    // create a relation based on the authors key
    AVRelation *relation = [fristComment relationForKey:@"secondComment"];
    
    // generate a query based on that relation
    AVQuery *query = [relation query];
    
    // now execute the query
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSMutableArray *mArray = [NSMutableArray array];
        for (SWComment *c in objects) {
            SWLog(@"%@",c);
            [mArray addObject:c];
        }
        
        completion(mArray); // 传值 刷新
    }];
}

@end
