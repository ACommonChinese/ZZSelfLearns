//
//  RealSubject.m
//  NSProxyDemo
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "RealSubject.h"

@implementation RealSubject

- (void)fun {
    NSLog(@"%s", __func__);
}

- (void)otherFun {
    // 此方法不需要代理做任何事情,可直接被调用
    // Do something real
    NSLog(@"%s", __func__);
}

@end
