//
//  BaseViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,strong)UIWindow *window;
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 登录状态（当前用户，不登出会一直在）
    self.currentUser = [AVUser currentUser];
    if (self.currentUser) {
        // 跳转到首页
        SWLog(@"用户 = %@",self.currentUser);
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        SWLog(@"用户 = %@",self.currentUser);
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 根视图控制器（tabBarController）
    self.rootVC = (RootViewController *)[[UIApplication sharedApplication].keyWindow rootViewController];
#warning --------------
//    UINavigationController *nacV = [[UINavigationController alloc]initWithRootViewController:self.rootVC];
//   
//    RootViewController *rootVC = [[RootViewController alloc]init];
//    
//    self.window.rootViewController = nacV;
    // 视图控制器view背景色
//    self.view.backgroundColor = [UIColor colorWithRed:78/256.0 green:78/256.0 blue:78/256.0 alpha:1.0];
}

#pragma mark ---- 父类方法

// 详情页面头背景图
- (UIView *)backgrandHeaderView {
    if (!_backgrandHeaderView) {
        _backgrandHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 2 / 3)];
        _backgrandHeaderView.backgroundColor = kImageColor;
    }
    return _backgrandHeaderView;
}

// 获取文件夹
- (NSString *)documentPath {
    if (!_documentPath) {
        _documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    }
    return _documentPath;
}
- (void)saveUserInfoWith:(AVUser *)user {
    // 保存
    [[NSUserDefaults standardUserDefaults] setObject:user.sessionToken forKey:@"LeanCloudUser"];
    //    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)removeUserInfoWith:(AVUser *)user {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LeanCloudUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark --- 获取缓存大小（getter方法）
- (float)cacheFileSize {
    if (!_cacheFileSize) {
        //文件管理
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //缓存路径
        NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *cacheDir = [cachePaths objectAtIndex:0];
        SWLog(@"%@",cacheDir);
        NSArray *cacheFileList;
        NSEnumerator *cacheEnumerator;
        NSString *cacheFilePath;
        unsigned long long cacheFolderSize = 0;
        cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
        cacheEnumerator = [cacheFileList objectEnumerator];
        while (cacheFilePath = [cacheEnumerator nextObject])
        {
            NSDictionary *cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
            cacheFolderSize += [cacheFileAttributes fileSize];
        }
        //单位MB
        return cacheFolderSize/1024/1024;
    }
    return _cacheFileSize;
}

#pragma mark --- 清除缓存方法
- (void)removeCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    for (NSString *string in cachePaths)
    {
        if ([fileManager fileExistsAtPath:string])
        {
            NSError *error = nil;
            if([fileManager removeItemAtPath:string error:&error])
            {
                SWLog(@"文件移除成功");
            } else
            {
                SWLog(@"error=%@", error);
            }
        }
    }
}
#pragma mark --- 数组转换为字符串
- (NSString *)getStringWithArray:(NSArray *)array {
    
    NSMutableString *str = [NSMutableString string];
    for (NSString * obj in array) {
        [str appendFormat:@"%@ ",obj];
    }
    return str;
    
}

// 一对一对的键值对 -- 增加持久化的字典的内容
- (void)addSaveK8VWithDicName:(NSString *)dicName Key:(NSString *)key Value:(NSString *)value {
    
    NSString *dicPath = [self.documentPath stringByAppendingPathComponent:dicName];
    if ([self getMarkWithKey:@"xxoo" marcoPath:dicName]) {
        
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithContentsOfFile:dicPath];
        [resultDic setObject:value forKey:key];
        [resultDic writeToFile:dicPath atomically:YES];
    }else {
        NSMutableDictionary *mDic = @{@"xxoo":@"1"}.mutableCopy;
        [mDic setObject:value forKey:key];
        [mDic writeToFile:dicPath atomically:YES];
    }
}
// 写入字典plist
- (void)goToSaveK8VWithDicName:(NSString *)dicName Dic:(NSDictionary *)dic {
    NSString *dicPath = [self.documentPath stringByAppendingPathComponent:dicName];
    if ([self getMarkWithKey:@"xxoo" marcoPath:dicName]) {
        
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithContentsOfFile:dicPath];
        for (NSString *key in dic) {
            [resultDic setObject:dic[key] forKey:key];
        }
        [resultDic writeToFile:dicPath atomically:YES];
        
    }else {
        NSMutableDictionary *resultDic = @{@"xxoo":@"1"}.mutableCopy;
        for (NSString *key in dic) {
            [resultDic setObject:dic[key] forKey:key];
        }
        [resultDic writeToFile:dicPath atomically:YES];
    }
    
}
// 读取字典的key对应的value
- (NSString *)getMarkWithKey:(NSString *)key marcoPath:(NSString *)marcoPath {
    NSString *dicPath = [self.documentPath stringByAppendingPathComponent:marcoPath];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:dicPath];
    return resultDic[key];
}

- (void)aalertViewShowWithMessage:(NSString *)message title:(NSString *)title otherTitle:(NSString *)otherTitle {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:title otherButtonTitles:otherTitle, nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //        UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        //        RegisterViewController *rVC = [mainSb instantiateViewControllerWithIdentifier:@"RegisterViewController"];
        //        [self presentViewController:rVC animated:YES completion:^{}];
    }else {
        SWLogFunc;
    }
}
// 未实现的方法
- (void)alertControllerShowWith:(NSString *)title {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    UIAlertAction *aA = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:aA];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
