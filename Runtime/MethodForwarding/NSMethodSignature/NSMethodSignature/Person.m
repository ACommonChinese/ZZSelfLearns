//
//  Person.m
//  NSMethodSignature
//
//  Created by liuweizhen on 2017/11/14.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)test {
    int a = 1;
    int b = 2;
    int c = 3;
}

- (int)myLog:(int)a param:(int)b param:(int)c {
    NSLog(@"MyLog: %d, %d, %d", a, b, c);
    return a + b + c;
}

@end
