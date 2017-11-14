//
//  TargetProxy.h
//  NSProxyDemo
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetProxy : NSProxy {
    id _realObject1;
    id _realObject2;
}

- (id)initWithTarget:(id)t1 target2:(id)t2;
@end
