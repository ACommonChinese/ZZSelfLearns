//
//  MasterPerson.m
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "MasterPerson.h"

@implementation MasterPerson

- (MasterPerson * (^)(NSString *))masterThink {
    return ^MasterPerson *(NSString *str) {
        NSLog(@"masterThink: %@", str);
        return self;
    };
}

@end
