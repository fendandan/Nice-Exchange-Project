//
//  SWAppDelegate.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/12.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWAppDelegate.h"

@interface SWAppDelegate ()

@end

@implementation SWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    
    
    
    self.swWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.swWindow makeKeyAndVisible];
    
    RootViewController *rootVC = [[RootViewController alloc] init];
    
#warning  message ----- 直接把今天要写的主控制器界面替换到navigationController的根视图控制器（这要就可以直接看到效果了）如下面的第四个navigationController控制器的根视图是MyViewController。
    UIViewController * vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    SWNavigationViewController *swNVCfir = [[SWNavigationViewController alloc] initWithRootViewController:vc];
    SWNavigationViewController *swNVCsec = [[SWNavigationViewController alloc] initWithRootViewController:[UIViewController new]];
    SWNavigationViewController *swNVCThr = [[SWNavigationViewController alloc] initWithRootViewController:[SWFocusonViewController new]];
    SWNavigationViewController *swNVCFou = [[SWNavigationViewController alloc] initWithRootViewController:[MyViewController new]];
    
    [rootVC addChildViewController:swNVCfir];
    [rootVC addChildViewController:swNVCsec];
    [rootVC addChildViewController:swNVCThr];
    [rootVC addChildViewController:swNVCFou];
    
//    UINavigationController *sNC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    [self.swWindow setRootViewController:rootVC];
    
    
    return YES;
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
