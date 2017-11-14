//
//  main.m
//  HookDemo_2
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person2.h"
#import "ZZHookManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        [ZZHookManager hookObject:Person.class method:@selector(learn:) toObject:Person2.class toMethod:@selector(learn:)];
        [p learn:@"English"];
    }
    return 0;
}
