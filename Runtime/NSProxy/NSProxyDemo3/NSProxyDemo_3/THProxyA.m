//
//  THProxyA.m
//  NSProxyDemo_3
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "THProxyA.h"

@implementation THProxyA

- (instancetype)initWithObject:(id)object {
    self.target = object;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
