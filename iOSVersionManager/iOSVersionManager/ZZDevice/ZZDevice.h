//
//  ZZDevice.h
//  iOSVersionManager
//
//  Created by liuweizhen on 2017/10/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 版本判断
 使用方法：
 if (ZZDevice.versionAvailable(__IPHONE_7_0)) {
    ...
 }
 */
@interface ZZDevice : NSObject

+ (BOOL (^)(NSInteger))versionAvailable;

@end
