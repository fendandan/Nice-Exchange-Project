//
//  DataBaseHandle.m
//  SQLite2
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 Ly. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>
#import "SWDraftModel.h"


@interface DataBaseHandle ()

//数据库的存储路径
@property(nonatomic,strong)NSString *dbPath;

@end


static DataBaseHandle *dataBase = nil;


@implementation DataBaseHandle

//把这个类写成单例,方便外部使用
+(DataBaseHandle *)shareDataBaseHandle
{
    if (dataBase == nil) {
        dataBase = [[DataBaseHandle alloc] init];
    }
    return dataBase;
}

//懒加载 给数据库路径
-(NSString *)dbPath{
    if (_dbPath == nil) {
        
        NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        _dbPath = [document stringByAppendingPathComponent:@"linkman.sqlite"];
    }
    return _dbPath;
}


//全局变量
static sqlite3 *db = nil;



//打开数据库
- (void)openDB{
//    第一个参数:代表的是数据库的路径
//    第二个参数:二级指针,代表的是数据库中的地址
    int result = sqlite3_open(self.dbPath.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    }else{
        NSLog(@"打开失败");
    }
}




//创建表
- (void)creatTable{
    
    NSString *creatStr = @"create table if not exists linkman (id integer primary key autoincrement,title text, content text ,label text ,rule text ,latitude double ,longitude double ,subhead text )";
    
    int result = sqlite3_exec(db, creatStr.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
    NSLog(@"_dbPath = %@",self.dbPath);
    
}


//关闭数据库
- (void)closeDB{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    }else{
        NSLog(@"数据库关闭失败");
    }
}

//插入数据
- (void)insertTitle:(NSString *)title
            content:(NSString *)content
              label:(NSString *)label
               rule:(NSString *)rule
           latitude:(double )latitude
          longitude:(double )longitude
            subhead:(NSString *)subhead
{

    NSString *insertStr = @"insert into linkman(title,content,label,rule,latitude,longitude,subhead)values(?,?,?,?,?,?,?)";

    sqlite3_stmt *stmt = nil;

    int result = sqlite3_prepare(db, insertStr.UTF8String, -1, &stmt, NULL);

    if (result == SQLITE_OK) {

        sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);
        
        sqlite3_bind_text(stmt, 2, content.UTF8String, -1, NULL);

        sqlite3_bind_text(stmt, 3, label.UTF8String, -1, NULL);
       
        sqlite3_bind_text(stmt, 4, rule.UTF8String, -1, NULL);
    
        sqlite3_bind_double(stmt, 5, -1);
        
        sqlite3_bind_double(stmt, 6, -1);
        
        sqlite3_bind_text(stmt, 7, subhead.UTF8String, -1, NULL);
       
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            NSLog(@"插入成功");
        }else {
            NSLog(@"插入失败");
        }
        
    }
    sqlite3_finalize(stmt);
}




//通过 uid 去更新数据
- (void)updateWithUID:(NSInteger)uid{
    
//    准备sql语句
    NSString *updateStr = @"update linkman set title = '戈壁老王' where id = ?";
//    创建伴随指针
    sqlite3_stmt *stmt = nil;
//    准备 sql 函数
    int result = sqlite3_prepare(db, updateStr.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        //绑定:
        sqlite3_bind_int64(stmt, 1, uid);
        
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            NSLog(@"更新成功");
        }else{
            NSLog(@"更新失败");
        }
    }
    sqlite3_finalize(stmt);
    
}





//通过 uid 去删除数据
- (void)deleteWithUID:(NSInteger)uid{
    NSString *deleteStr = [NSString stringWithFormat:@"delete from linkman where id = %ld",uid];
    //sql 函数
    int result =  sqlite3_exec(db, deleteStr.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}


//NSString *creatStr = @"create table if not exists linkman (id integer primary key autoincrement,title text, content text ,label text ,rule text ,latitude text ,longitude text ,c text )";


//查找所有数据
- (NSMutableArray *)searchAll{
    
    NSString *searchAllStr = @"select * from linkman";
    
    sqlite3_stmt *stmt = NULL;
    
    int result = sqlite3_prepare(db, searchAllStr.UTF8String, -1, &stmt, NULL);
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            
            SWDraftModel *model = [SWDraftModel new];
            
            
            
            
            //注意这里不是 OK 这里表示还有下一条数据
            NSInteger id = sqlite3_column_int(stmt, 0);//第二个参数是指位置从0开始
            NSLog(@"%ld",id);
            
            model.ID = id;
            
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSLog(@"%@",title);
            model.title = title;
            
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSLog(@"%@",content);
            
            model.content = content;
            
            NSString *label = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 3)];
            NSLog(@"%@",label);
            
            model.label = label;
            
            NSString *rule = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 4)];
            NSLog(@"%@",rule);
            
            
            model.rule = rule;
            
            double latitude = sqlite3_column_double(stmt, 5);
            NSLog(@"%f",latitude);
            
            model.latitude = latitude;
            
            double longitude = sqlite3_column_double(stmt, 6);
            NSLog(@"%f",longitude);
            
            model.longitude = longitude;
            
            NSString *subhead = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 7)];
            NSLog(@" ---- %@",subhead);
            
            model.subhead = subhead;
            
            SWLog(@" ++++++++++ %@",self.dbPath);
            
            [dataArray addObject:model];
            
        }
        sqlite3_finalize(stmt);
        return dataArray;
    }
    return nil;
}


//根据名字去查找相关数据
- (void)searchWithTitle:(NSString *)title{
   NSString *searchStr = @"select * from linkman where title = ?";
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(db, searchStr.UTF8String, -1, &stmt, NULL);//sql 语句
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);//绑定参数
        while ( sqlite3_step(stmt) == SQLITE_ROW) {
                    //从伴随指针回去数据第0行
            int ID = sqlite3_column_int(stmt, 0);
            NSLog(@"%d",ID);
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSLog(@"%@",title);
            
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSLog(@"%@",content);
            
            NSString *label = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 3)];
            NSLog(@"%@",label);
            
            NSString *rule = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 4)];
            NSLog(@"%@",rule);
            
            //            NSString *latitude = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 5)];
            //            NSLog(@"%@",latitude);
            
            
            //            NSString *longitude = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 6)];
            //            NSLog(@"%@",longitude);
            
            
            NSString *subhead = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 7)];
            NSLog(@"%@",subhead);
          }
    }else{
        NSLog(@"语句错误");
    }
    
//    关闭伴随指针
    sqlite3_finalize(stmt);
     
}





@end
