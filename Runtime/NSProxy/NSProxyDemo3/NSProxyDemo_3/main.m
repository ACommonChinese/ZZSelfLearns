//
//  main.m
//  NSProxyDemo_3
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THProxyA.h"
#import "THProxyB.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *string = @"test";
        THProxyA *proxyA = [[THProxyA alloc] initWithObject:string];
        THProxyB *proxyB = [[THProxyB alloc] initWithObject:string];
        NSLog(@"%d", [proxyA respondsToSelector:@selector(length)]); // 1
        NSLog(@"%d", [proxyB respondsToSelector:@selector(length)]); // 0
        NSLog(@"%d", [proxyA isKindOfClass:[NSString class]]); // 1
        NSLog(@"%d", [proxyB isKindOfClass:[NSString class]]); // 0
        NSLog(@"%@", [proxyA valueForKey:@"length"]); // 4
        // NSLog(@"%@", [proxyB valueForKey:@"length"]); // Crash: [<THProxyB 0x100704da0> valueForUndefinedKey:]: this class is not key value coding-compliant for the key length.'
    }
    // 试验证明: 通过继承自NSObject的代理类是不会自动转发respondsToSelector:和isKindOfClass:这两个方法的, 而继承自NSProxy的代理类却是可以的.
    // 调用proxyA的valueForKey:方法程序正常运行. 但调用proxyB的valueForKey:方法抛出异常, 原因其实很简单, 因为valueForKey:是NSObject的Category中定义的方法, 让NSObject具备了这样的接口, 而消息转发是只有当接收者无法处理时才会通过forwardInvocation:来寻求能够处理的对象.
    // 结论: 如此看来NSProxy确实更适合实现做为消息转发的代理类, 因为作为一个抽象类, NSProxy自身能够处理的方法极小(仅<NSObject>接口中定义的部分方法), 所以其它方法都能够按照设计的预期被转发到被代理的对象中.
    return 0;
}
