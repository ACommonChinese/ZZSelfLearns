//
//  TargetProxy.m
//  NSProxyDemo
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "TargetProxy.h"

@implementation TargetProxy

- (id)initWithTarget:(id)t1 target2:(id)t2 {
    _realObject1 = t1;
    _realObject2 = t2;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *sig = [_realObject1 methodSignatureForSelector:sel];
    if (sig) return sig;
    sig = [_realObject2 methodSignatureForSelector:sel];
    return sig;
}

// Invoke the invocation on whichever real object had a signature for it.
- (void)forwardInvocation:(NSInvocation *)invocation {
    id target = [_realObject1 methodSignatureForSelector:[invocation selector]] ? _realObject1 : _realObject2;
    // SEL selector = invocation.selector;
    // NSLog(@"调用方法前:%@", NSStringFromSelector(selector));
    [invocation invokeWithTarget:target];
    // NSLog(@"调用方法后:%@", NSStringFromSelector(selector));
}

// Override some of NSProxy's implementations to forward them...
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([_realObject1 respondsToSelector:aSelector]) return YES;
    if ([_realObject2 respondsToSelector:aSelector]) return YES;
    return NO;
}

@end
