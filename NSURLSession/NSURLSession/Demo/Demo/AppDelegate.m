//
//  AppDelegate.m
//  Demo
//
//  Created by 刘威振 on 4/15/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    // 大多数情况下，无论应用在后台启动或者在前台，你会执行相同的工作，但你可以通过查看UIApplication的applicationState属性来判断应用是不是从后台启动
    NSLog(@"Launched in background %d", UIApplicationStateBackground == application.applicationState);
    
    return YES;
}

// 程序处于挂起状态，系统先唤醒应用，然后调用此方法。可以把这种应用程序的运行的方式想像为用户从Springboard启动这个程序，区别是界面是看不见的，在屏幕外渲染的
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    UINavigationController *nivController = (UINavigationController *)self.window.rootViewController;
    id fetchViewController = nivController.topViewController;
    if ([fetchViewController respondsToSelector:@selector(backgroundFetchWithCompletion:)]) {
        [fetchViewController backgroundFetchWithCompletion:^{
            completionHandler(UIBackgroundFetchResultNewData);
        }];
    } else {
        completionHandler(UIBackgroundFetchResultFailed);
    }
}

// 后台下载任务完成后，程序被唤醒，该方法将被调用
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(nonnull NSString *)identifier completionHandler:(nonnull void (^)())completionHandler {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // 设置回调的完成代码块
    self.backgroundSessionHandler = completionHandler;
}

- (void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    
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

@end
