//
//  ZZHookManager.m
//  HookDemo_2
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZHookManager.h"
#import <objc/runtime.h>

@implementation ZZHookManager

+ (void)hookObject:(Class)cls method:(SEL)method toObject:(Class)toCls toMethod:(SEL)toMethod {
    Method imp = class_getInstanceMethod(cls, method);
    Method swizzling = class_getInstanceMethod(toCls, toMethod);
    
//    BOOL isSuccess = class_addMethod(cls, @selector(learn), method_getImplementation(swizzling), method_getTypeEncoding(swizzling));
//    if (isSuccess) {
//        class_replaceMethod(cls, @selector(learn), method_getImplementation(imp), method_getTypeEncoding(imp));
//    } else {
//        method_exchangeImplementations(imp, swizzling);
//    }
    
    method_exchangeImplementations(imp, swizzling);
}

@end
