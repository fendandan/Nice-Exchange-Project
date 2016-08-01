//
//  DataBaseHandle.h
//  SQLite2
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 Ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseHandle : NSObject


//把这个类写成单例,方便外部使用
+(DataBaseHandle *)shareDataBaseHandle;


//打开数据库
- (void)openDB;

//关闭数据库
- (void)closeDb;

//创建表
- (void)creatTable;

//插入数据
- (void)insertTitle:(NSString *)title
            content:(NSString *)content
              label:(NSString *)label
               rule:(NSString *)rule
           latitude:(double )latitude
          longitude:(double )longitude
            subhead:(NSString *)subhead
               time:(NSString *)tim;

//通过 uid 去更新数据
- (void)updateWithUID:(NSInteger)uid;

//通过 uid 去删除数据
- (void)deleteWithUID:(NSInteger)uid;

//查找所有数据
- (NSMutableArray *)searchAll;

//根据名字去查找相关数据
- (void)searchWithName:(NSString *)name;

@end
