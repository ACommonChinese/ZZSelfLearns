//
//  Person+Hook.m
//  HookDemo_1
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "Person+Hook.h"
#import <objc/runtime.h>

@implementation Person (Hook)

+ (void)load {
    [super load];
    
    return;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method imp = class_getInstanceMethod(self, @selector(learn));
        Method swizzling = class_getInstanceMethod(self, @selector(zz_learn));
        
//        BOOL isSuccess = class_addMethod(self, @selector(learn), method_getImplementation(swizzling), method_getTypeEncoding(swizzling));
//        if (isSuccess) {
//            class_replaceMethod(self, @selector(zz_learn), method_getImplementation(imp), method_getTypeEncoding(imp));
//        } else {
//            method_exchangeImplementations(imp, swizzling);
//        }
        
         method_exchangeImplementations(imp, swizzling);
    });
}

- (void)zz_learn {
    [self zz_learn];
    NSLog(@"Person+Hook: zz_learn");
}

@end
