//
//  LBDevice.h
//  LBLingDang
//
//  Created by liuweizhen on 2017/10/9.
//  Copyright © 2017年 联璧. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 版本判断
 * 使用方法示例：判断当前设备版本是否是7.0之后
 if (LBDevice.versionAvailable(__IPHONE_7_0)) {
     ...
 }
 */
@interface ZZDevice : NSObject

@property (nonatomic, class, copy, readonly) BOOL (^versionAvailable)(NSInteger versionNumber);
@end
