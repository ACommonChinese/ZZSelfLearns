//
//  main.m
//  HookDemo_1
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "ZZHookManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [ZZHookManager hookObject:Person.class method:@selector(learn) toObject:Person.class toMethod:@selector(zz_learn)];
        Person *p = [[Person alloc] init];
        [p learn];
    }
    return 0;
}
