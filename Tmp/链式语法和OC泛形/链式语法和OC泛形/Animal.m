//
//  Animal.m
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (id (^)(NSString *))eat {
    return ^Animal *(NSString *str){
        NSLog(@"eat: %@", str);
        return self;
    };
}

- (id (^)(NSString *))drink {
    return ^Animal *(NSString *str){
        NSLog(@"drink: %@", str);
        return self;
    };
}

- (id (^)(NSString *))think {
    return ^Animal *(NSString *str){
        NSLog(@"think: %@", str);
        return self;
    };
}

- (id (^)(NSString *))hit {
    return ^Animal *(NSString *str) {
        NSLog(@"hit: %@", str);
        return self;
    };
}

@end
