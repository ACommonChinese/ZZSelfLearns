//
//  ZZiOSVersion.h
//  iOSVersionManager
//
//  Created by liuweizhen on 2017/11/11.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZiOSVersion : NSObject

/**
 版本判断
 使用方法：
 if (ZZiOSVersion.versionAvailable(__IPHONE_7_0)) {
     ...
 }
 */
+ (BOOL (^)(NSInteger))versionAvailable;
@end
