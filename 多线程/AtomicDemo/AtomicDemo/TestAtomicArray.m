//
//  TestAtomicArray.m
//  AtomicDemo
//
//  Created by liuweizhen on 2017/12/5.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "TestAtomicArray.h"

@interface TestAtomicArray()

@property (atomic) NSMutableArray *itemArray;
@end

@implementation TestAtomicArray

- (instancetype)init {
    if (self = [super init]) {
        self.itemArray = [NSMutableArray array];
    }
    return self;
}

- (void)test {
    NSThread *t1 = [[NSThread alloc] initWithBlock:^{
        for (int i = 0; i < 100; i++) {
            sleep(1);
            [self.itemArray addObject:[NSString stringWithFormat:@"%d", i]];
            NSLog(@"%@ ----> %@", [[NSThread currentThread] name], [self.itemArray lastObject]);
        }
    }];
    t1.name = @"线程1";
    [t1 start];
    
    NSThread *t2  = [[NSThread alloc] initWithBlock:^{
        for (int i = 101; i < 200; i++) {
            sleep(1);
            [self.itemArray addObject:[NSString stringWithFormat:@"%d", i]];
            NSLog(@"%@ ----> %@", [[NSThread currentThread] name], [self.itemArray lastObject]);
        }
    }];
    t2.name = @"线程2";
    [t2 start];
}

@end
