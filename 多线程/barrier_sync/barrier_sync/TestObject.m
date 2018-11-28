//
//  TestObject.m
//  barrier_sync
//
//  Created by liuweizhen on 2018/10/15.
//  Copyright © 2018年 liuxing8807@126.com All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

+ (void)testSync {
    dispatch_queue_t queue = dispatch_queue_create("thread", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"test1");
    });
    dispatch_async(queue, ^{
        NSLog(@"test2");
    });
    dispatch_async(queue, ^{
        NSLog(@"test3");
    });
    dispatch_barrier_sync(queue, ^{ // sync会阻塞当前线程，因此"hello"和"world"的打印在test1/2/3之后
        sleep(1);
        for (int i = 0; i < 50; i++) {
            if (i == 10 ) {
                NSLog(@"point1");
            } else if (i == 20){
                NSLog(@"point2");
            } else if (i == 40){
                NSLog(@"point3");
            }
        }
    });
    NSLog(@"hello");
    dispatch_async(queue, ^{
        NSLog(@"test4");
    });
    NSLog(@"world");
    dispatch_async(queue, ^{
        NSLog(@"test5");
    });
    dispatch_async(queue, ^{
        NSLog(@"test6");
    });
    /**
     test2
     test3
     test1
     point1
     point2
     point3
     hello
     world
     test4
     test5
     test6
     结论：dispatch_barrier_sync(queue,void(^block)())会将queue中barrier前面添加的任务block全部执行后, 再执行barrier任务的block,再执行barrier后面添加的任务block. 另外，由于是sync, 它会阻塞当前线程，导致在queue中barrier前面添加的任务的block执行完成之前当前线程阻塞
     */
}

+ (void)testAsync {
    dispatch_queue_t queue = dispatch_queue_create("thread", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"test1");
    });
    dispatch_async(queue, ^{
        NSLog(@"test2");
    });
    dispatch_async(queue, ^{
        NSLog(@"test3");
    });
    dispatch_barrier_async(queue, ^{ // sync会阻塞线程
        sleep(1);
        for (int i = 0; i < 50; i++) {
            if (i == 10 ) {
                NSLog(@"point1");
            } else if (i == 20){
                NSLog(@"point2");
            } else if (i == 40){
                NSLog(@"point3");
            }
        }
    });
    NSLog(@"hello");
    dispatch_async(queue, ^{
        NSLog(@"test4");
    });
    NSLog(@"world");
    dispatch_async(queue, ^{
        NSLog(@"test5");
    });
    dispatch_async(queue, ^{
        NSLog(@"test6");
    });
    /**
     test2
     test3
     hello
     world
     test1
     point1
     point2
     point3
     test6
     test4
     test5

     类同dispatch_async, 但由于是async, 因此它不影响当前线程的执行。
     */
}

@end
