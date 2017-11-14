//
//  Person2.m
//  HookDemo_2
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "Person2.h"

@implementation Person2

- (void)learn:(NSString *)info {
    NSLog(@"Person2 learn: %@", info);
    [self learn:info];
}

@end
