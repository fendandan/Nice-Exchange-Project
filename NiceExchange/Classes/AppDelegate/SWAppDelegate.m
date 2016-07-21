//
//  SWAppDelegate.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWAppDelegate.h"
#warning  友盟第三方
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
@interface SWAppDelegate ()

@end

@implementation SWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SWActivityList registerSubclass];
    [SWLcAvUSer registerSubclass];
    [SWCount registerSubclass];
    [SWMark registerSubclass];
    [SWFollow registerSubclass];
    
    // LeanCloud
    // applicationId 即 App Id，clientKey 是 App Key。
    [AVOSCloud setApplicationId:@"8nI1eCRtiepkR5jBEUt8lGNK-gzGzoHsz"
                      clientKey:@"Q3pfWyG7k7m6277yCulivB3B"];
    // 跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    
    self.swWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.swWindow makeKeyAndVisible];
    
    RootViewController *rootVC = [[RootViewController alloc] init];
#warning  message ----- 直接把今天要写的主控制器界面替换到navigationController的根视图控制器（这要就可以直接看到效果了）如下面的第四个navigationController控制器的根视图是MyViewController。
   
    
    UINavigationController *sNC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self.swWindow setRootViewController:sNC];
    
    
#warning 设置你的友盟Appkey，在 AppDelegate文件内设置你的AppKey：
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
 
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/* 单例 */
static SWAppDelegate *swAppDelegate = nil;
+ (instancetype)shareSWAppDelegate {
    if (!swAppDelegate) {
        swAppDelegate = [[SWAppDelegate alloc] init];
    }
    return swAppDelegate;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (swAppDelegate) {
        if (!swAppDelegate) {
            swAppDelegate = [super allocWithZone:zone];
        }
    }
    return swAppDelegate;
}

@end
