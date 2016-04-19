//
//  AppDelegate.h
//  NSURLSessionDownloadDemo
//
//  Created by 刘威振 on 12/28/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 用于保存后台下载任务完成后的回调代码块
@property (nonatomic, copy) void (^backgroundURLSessionCompletionHandler)();

@end

