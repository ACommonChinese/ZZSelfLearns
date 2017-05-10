//
//  main.m
//  2_PropertyAttributes
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *dict = @{@"id"    : @"0000001",
                               @"name"  : @"刘威振",
                               @"age"   : @30,
                               @"score" : @100.0
                               };
        Student *s = [[Student alloc] initWithKeyValues:dict];
        [s printInfo];
    }
    return 0;
}
