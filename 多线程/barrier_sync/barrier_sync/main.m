//
//  main.m
//  barrier_sync
//
//  Created by liuweizhen on 2018/10/15.
//  Copyright © 2018年 liuxing8807@126.com All rights reserved.
//  https://blog.csdn.net/willluckysmile/article/details/61195571
//

#import <Foundation/Foundation.h>
#import "TestObject.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // [TestObject testSync];
        [TestObject testAsync];
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
