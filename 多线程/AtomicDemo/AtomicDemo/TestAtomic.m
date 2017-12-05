//
//  TestAtomic.m
//  AtomicDemo
//
//  Created by liuweizhen on 2017/12/5.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "TestAtomic.h"

@interface TestAtomic()

@property (atomic, assign) NSInteger value;
@end

@implementation TestAtomic

- (void)test {
    NSThread *t1 = [[NSThread alloc] initWithBlock:^{
        while (YES) {
            self.value = 100;
            NSLog(@"%@ --> %ld", [[NSThread currentThread] name], self.value);
        }
    }];
    t1.name = @"线程1";
    [t1 start];
    
    NSThread *t2  = [[NSThread alloc] initWithBlock:^{
        while (YES) {
            self.value = 200;
            NSLog(@"%@ --> %ld", [[NSThread currentThread] name], self.value);
        }
    }];
    t2.name = @"线程2";
    [t2 start];
}

@end
