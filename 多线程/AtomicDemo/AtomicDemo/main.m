//
//  main.m
//  AtomicDemo
//
//  Created by liuweizhen on 2017/12/5.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestAtomic.h"
#import "TestAtomicArray.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /**
        TestAtomic *test = [[TestAtomic alloc] init];
        [test test];
         */
        
        TestAtomicArray *test = [[TestAtomicArray alloc] init];
        [test test];
        
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}

