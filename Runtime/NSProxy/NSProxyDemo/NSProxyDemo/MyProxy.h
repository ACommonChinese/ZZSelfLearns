//
//  MyProxy.h
//  NSProxyDemo
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RealSubjectProtocol.h"

@interface MyProxy : NSProxy <RealSubjectProtocol> {
    NSObject *_object;
}

- (id)transformToObject:(NSObject *)anObject;

@end
