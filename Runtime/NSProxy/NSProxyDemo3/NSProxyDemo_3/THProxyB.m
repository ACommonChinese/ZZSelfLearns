//
//  THProxyB.m
//  NSProxyDemo_3
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "THProxyB.h"

@implementation THProxyB

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        self.target = object;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.target];
}

@end
