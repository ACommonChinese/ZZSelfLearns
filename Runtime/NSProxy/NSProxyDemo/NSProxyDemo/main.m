//
//  main.m
//  NSProxyDemo
//
//  Created by liuweizhen on 2017/11/11.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetProxy.h"
#import "MyProxy.h"
#import "RealSubject.h"

/// NSProxy消息转发
void test1() {
    // Create an empty mutable string, which will be one of the
    // real objects for the proxy.
    NSMutableString *string = [[NSMutableString alloc] init];
    // Create an empty mutable array, which will be the other
    // real object for the proxy.
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    /// Create a proxy to wrap the real objects. This is rather artificial(人造的,人为的,虚假的) for the purposes of this example -- you'd rarely have a single proxy convering two objects. But it it spossible.
    id proxy = [[TargetProxy alloc] initWithTarget:string target2:array];
    
    NSString *testStr = @"You are my destiny!";
    [proxy appendFormat:@"%@", testStr];
    [proxy appendString:@" This "];
    [proxy appendString:@"is "];
    [proxy addObject:string];
    [proxy appendString:@"a "];
    [proxy appendString:@"test!"];
    
    NSLog(@"count should be 1, it is: %ld", [proxy count]);
    NSLog(@"get the final string: %@", string);
}

void test2() {
    MyProxy *myProxy = [MyProxy alloc];
    RealSubject *realSub = [[RealSubject alloc] init];
    [myProxy transformToObject:realSub];
    [myProxy fun];
    [myProxy otherFun];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // test1();
        test2();
    }
    return 0;
}
