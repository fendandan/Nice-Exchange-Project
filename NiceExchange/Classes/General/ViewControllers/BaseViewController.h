//
//  BaseViewController.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RootViewController;
@interface BaseViewController : UIViewController

@property (strong, nonatomic) RootViewController *rootVC;
@property (strong, nonatomic) AVUser *currentUser;

/// 详情页面头背景图
@property (strong, nonatomic) UIImageView *backgrandHeaderView;

///// 是否刷新？
//@property BOOL bbb;
///// 收藏与否
//@property BOOL bool1;

@property (strong, nonatomic) NSString *documentPath;
@property (assign, nonatomic) float cacheFileSize;

/// 登陆保存用户user.sessionToken
- (void)saveUserInfoWith:(AVUser *)user;
/// 注销时移除用户user.sessionToken
- (void)removeUserInfoWith:(AVUser *)user;


//- (void)addRightNavigationItemBarButton;

/// 清除缓存方法
- (void)removeCache;

/// 一对一对的键值对 -- 增加持久化的字典的内容
- (void)addSaveK8VWithDicName:(NSString *)dicName Key:(NSString *)key Value:(NSString *)value;
/// 写入字典plist文件到本地
- (void)goToSaveK8VWithDicName:(NSString *)dicName Dic:(NSDictionary *)dic;
/// 读取字典的key对应的value
- (NSString *)getMarkWithKey:(NSString *)key marcoPath:(NSString *)marcoPath;

/// 数组转换为字符串
- (NSString *)getStringWithArray:(NSArray *)array;

/// 创建alertView 并 show  （注意代理方法）
- (void)aalertViewShowWithMessage:(NSString *)message title:(NSString *)title otherTitle:(NSString *)otherTitle;

@end
