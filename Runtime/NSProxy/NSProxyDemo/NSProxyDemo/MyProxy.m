//
//  MyProxy.m
//  NSProxyDemo
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//  http://www.360doc.com/content/15/0906/17/26281448_497288561.shtml

#import "MyProxy.h"

@implementation MyProxy

- (id)transformToObject:(NSObject *)anObject {
    _object = anObject;
    return _object;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSLog(@"forwardInvocation: %@", NSStringFromSelector(invocation.selector));
    if (_object) {
        // [invocation setTarget:_object];
        // [invocation invoke];
        [invocation invokeWithTarget:_object];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *sig;
    if (_object != nil) {
        sig = [_object methodSignatureForSelector:sel];
    } else {
        sig = [super methodSignatureForSelector:sel];
    }
    return sig;
}

@end
