//
//  main.m
//  methodForward
//
//  Created by liuweizhen on 2017/11/11.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZMessage.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ZZMessage *message = [[ZZMessage alloc] init];
        [message sendMessage:@"Hello world!"];
    }
    return 0;
}
