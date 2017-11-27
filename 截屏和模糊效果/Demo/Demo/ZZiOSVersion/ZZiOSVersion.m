//
//  ZZiOSVersion.m
//  iOSVersionManager
//
//  Created by liuweizhen on 2017/11/11.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZiOSVersion.h"
@import UIKit;

@implementation ZZiOSVersion

+ (BOOL (^)(NSInteger))versionAvailable {
    return ^BOOL(NSInteger versionNumber) {
        NSString *version = [[UIDevice currentDevice] systemVersion];
        NSArray *components = [version componentsSeparatedByString:@"."];
        NSInteger value = 0;
        for (NSInteger i = 0; i < components.count; i++) {
            NSInteger numValue       = [components[i] integerValue];
            NSInteger multiValue     = (NSInteger)pow(10, (4-2*i)); // 10的4-2*i次方
            NSInteger componentValue = numValue * multiValue;
            value += componentValue;
        }
        // NSLog(@"%ld", value);
        return value >= versionNumber;
    };
}

@end
